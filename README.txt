Simple Event model implemented by Observer Pattern.

How to use
    Notification
        addListener:
            Notification.addNotification(type,callback);
        activeListener:
            Notification.sendNotification(type);
    Courier(similar to as3-signals)
        addListener:
            var listener:Courier = new Courier();
            listener.add(callback);
        activeListener:
            listener.send();