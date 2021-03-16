public with sharing class FlightSearchController {
    public FlightSearchController() {

    }

    @AuraEnabled
    public static list<String> getFrom(String fo){
        list<String> autowords=new List<String>();
        List<String> resultsli=new List<String>();

        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/US/USD/en-US/?query='+fo);
        request.setHeader('x-rapidapi-key', '743f4590a2msh9f16e2272d3dbe0p1a392cjsn18635a0e157d');
        request.setHeader('x-rapidapi-host', 'skyscanner-skyscanner-flight-search-v1.p.rapidapi.com');
        request.setMethod('GET'); 
        HttpResponse response=http.send(request);
        if(response.getStatusCode()==200){
            Map<String,Object> results=(Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> places=(List<Object>) results.get('Places');
            for (Object x : places) {
                Map<String,Object> a1=(Map<String,Object>) x;
                String placename=a1.get('PlaceId').toString();
                resultsli.add(placename);
            }

        }
        return resultsli;

    }
    @AuraEnabled
    public static List<FlightWrapper> getFlights(String fro,String des,String out){
        Integer orginid;
        integer desid;
        Integer carrierid;
        FlightWrapper flight=new FlightWrapper();
        List<FlightWrapper> flights=new List<FlightWrapper>();
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/US/USD/en-US/'+fro+'/'+des+'/'+out);
        request.setHeader('x-rapidapi-key', '743f4590a2msh9f16e2272d3dbe0p1a392cjsn18635a0e157d');
        request.setHeader('x-rapidapi-host', 'skyscanner-skyscanner-flight-search-v1.p.rapidapi.com');
        request.setMethod('GET'); 
        HttpResponse response=http.send(request);
        if(response.getStatusCode()==200){
            Map<String,Object> results=(Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> quotes =(List<Object>) results.get('Quotes');
            for(Object ob:quotes){
                Map<String,Object> quolist=(Map<String,Object>)ob;
                flight.MinPrice=(Integer)quolist.get('MinPrice');
                Map<String,Object> innerout=(Map<String,Object>)quolist.get('OutboundLeg');
                orginid=(Integer)innerout.get('OriginId');
                desid=(Integer)innerout.get('DestinationId');
                flight.departureDate=innerout.get('DepartureDate').toString();
                List<Object> carr=(List<Object>)innerout.get('CarrierIds');
                carrierid=(Integer)carr[0];
                List<Object> quotes2 =(List<Object>) results.get('Carriers');
                for(Object ob2:quotes2){
                    Map<String,Object> quolist2=(Map<String,Object>)ob2;
                    if(quolist2.get('CarrierId')==carrierid){
                        flight.CarrierName=quolist2.get('Name').toString();
                    }
            }
            List<Object> quotes3 =(List<Object>) results.get('Places');
            for(Object x:quotes3){
              Map<String,Object> plcmap=(Map<String,Object>)x;
              if(plcmap.get('PlaceId')==orginid){
                  flight.orgAirport=plcmap.get('Name').toString();
                  flight.orgAirportAlias=plcmap.get('IataCode').toString();
                  flight.orgCityName=plcmap.get('CityName').toString();
                  flight.orgCountryName=plcmap.get('CountryName').toString();

              }else if(plcmap.get('PlaceId')==desid){
                flight.desAirport=plcmap.get('Name').toString();
                flight.desAirportAlias=plcmap.get('IataCode').toString();
                flight.desCityName=plcmap.get('CityName').toString();
                flight.desCountryName=plcmap.get('CountryName').toString();

              }


            }
               flights.add(flight);
        }
    }
    return flights;

}
@AuraEnabled
public static void getTicket(FlightWrapper fle,String dd){
    Flight__c newflight=new Flight__c();
    newflight.Departure_Date__c=fle.departureDate;
    newflight.Price__c=fle.MinPrice;
    newflight.To_Airport__c=fle.desAirport;
    newflight.To_City__c=fle.desCityName;
    newflight.To_Country__c=fle.desCountryName;
    newflight.To_Airport_Code__c=fle.desAirportAlias;
    newflight.From_Airport__c=fle.orgAirport;
    newflight.From_City__c=fle.orgCityName;
    newflight.From_Country__c=fle.orgCountryName;
    newflight.From_Airport_Code__c=fle.orgAirportAlias;
    newflight.Carrier__c=fle.CarrierName;
    newflight.Ticket_Status__c='Confirmed';
    newflight.User__c=dd;

    insert newflight;

}

@AuraEnabled
public static void cancelTicket(FlightWrapper fle,String dd){
    Flight__c newflight=new Flight__c();
 

}
}
