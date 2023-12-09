import autoprefixer from 'autoprefixer';
import { watch } from 'chokidar';
import cssnano from 'cssnano';
import fs from 'fs';
import { createServer } from 'https';
import path from 'path';
import postcss from 'postcss';
import { fileURLToPath } from 'url';
import { WebSocketServer } from 'ws';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DEFAULT_PORT = 8080;
const SERVER_NAME = 'DOMAIN_NAME';
const CSS_FILES = `${__dirname}/../app/assets/css/**/*.css`;
const PHP_FILES = `${__dirname}/../app/**/*.php`;

const server = createServer({
  cert: fs.readFileSync(`${__dirname}/../certs/${SERVER_NAME}.pem`),
  key: fs.readFileSync(`${__dirname}/../certs/${SERVER_NAME}-key.pem`),
});
const wss = new WebSocketServer({ server });

wss.on('connection', (ws) => {
  ws.on('error', console.error);
  ws.on('message', () => {
    watch(CSS_FILES).on('change', (path) => {
      const outputFile = 'styles.css';
      const dist = `${path.split('/').slice(0, 7).join('/')}/public/${outputFile}`;

      ws.send(JSON.stringify({ type: 'change', path }, null, 2));
      fs.readFile(path, (error, css) => {
        try {
          postcss([cssnano, autoprefixer]).process(css, { from: path, to: dist }).then((result) => {
            fs.writeFile(dist, result.css, () => true);
            if (result.map) {
              fs.writeFile(`${dist}.map`, result.map.toString(), () => true);
            }
          });
        } catch {
          console.log(`Error while transforming CSS file (${path}): `, error.message);
        }
      });
    });
    watch(PHP_FILES).on('change', (path) => {
      ws.send(JSON.stringify({ type: 'change', path }, null, 2));
    })
  });
});

console.log(`[⌚️ Tokei.js] Watching for changes on port: ${DEFAULT_PORT}`);
server.listen(DEFAULT_PORT);
