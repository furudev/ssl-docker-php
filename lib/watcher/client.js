const init = () => {
  const SERVER_NAME = 'DOMAIN_NAME';

  if (!("WebSocket" in window)) {
    return;
  }

  const socket = new WebSocket(`wss://${SERVER_NAME}:8080`);

  socket.addEventListener('open', () => {
    console.log('[⌚️ Tokei.js] Connection established');
    socket.send('Initialize');
  });

  socket.addEventListener('message', async (event) => {
    const { type, path } = JSON.parse(event.data);

    if (type === 'change') {
      window.location.reload();
      socket.send('[⌚️ Tokei.js] File changed: ', path);
    }
  });
};

init();

