import consumer from "./consumer"
consumer.subscriptions.create("NotificationChannel", {

//App.notifications = App.cable.subscriptions.create("NotificationChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
  	//if (Notification.permission === 'granted') {
      //var title = 'Push Notification'
      //var body = data
      //var options = { body: body }
      //new Notification(title, options)
      	alert('hi');
      	alert('adsfasdf')
    // Called when there's incoming data on the websocket for this channel
    	$("#notifications").html(data);
    //	alert(data);
    //}
  
  }
});