import consumer from "channels/consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    // Called when there's incoming data on the websocket for this channel
    const html = `${data['html']}`;
    var notifications = document.querySelector('.notifications');
    notifications.insertAdjacentHTML('afterbegin', html);
    // var a1 = document.createElement('a');
    // a1.setAttribute('href', `/users/${data['user_id']}`);
    // a1.innerText = data['text'];
    // var a2 = document.createElement('a');
    // a2.setAttribute('href', `/notifications/${data['id']}`);
    // a2.setAttribute('data-turbo-method', 'delete');
    // var div = document.createElement('div');
    // div.innerHTML = `${a1} - ${a2}`;
    // notifications.prepend(div)
  },
});