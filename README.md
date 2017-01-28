# ActiveMQ
 
This is a proof of concept of AMQ running on a docker with some Camel filtering features. It is mainly intended for testing.

## 1. UI Admin
When running the service on your machine, the UI is reachable at http://localhost:8161/admin/queues.jsp.  
User: admin  
Pass: admin

## 2. Camel filtering
As a proof of concept, I'm playing with this dataset:
```JSON
{
  "id": "message1",
  "placesIveBeen": [
    {
      "country": "ES",
      "city": "Granada"
    }
  ]
}
```

```JSON
{
  "id": "message2",
  "socialNetwork": "meetme",
  "city": "Granada",
  "placesIveBeen": [
    {
      "country": "ES",
      "city": "Granada"
    },
    {
      "country": "ES",
      "city": "Madrid"
    }
  ]
}
```

As a proof of concept I want to test these scenarios (for all messages getting into `incoming.queue`):

|Scenario|Description|Destination queue|
|:---:|---|---|
|A|Separate between messages with and without the parameter `socialNetwork` (in both cases, try to populate the City)|`no.social.network` or `with-social-network`|
|B|Messages from `meetme` where main city is `Granada`|`meetme.Granada`|
|C|Messages from `meetme` where main city is `Granada` but also goes to other cities|`meetme.Granada.and.others`|

Improvements or comments are welcome :)