public with sharing class MyFlights {
    public MyFlights() {}
@AuraEnabled
public static List<Flight__C> flightList(){
    List<Flight__C> cons = [SELECT Id,Name, CreatedDate,Carrier__c,Departure_Date__c,From_Airport__c,From_Airport_Code__c,From_City__c,From_Country__c,
    Price__c,Ticket_Status__c,To_Airport__c,To_Airport_Code__c,To_City__c,To_Country__c	,User__c	 FROM Flight__C ];
        return cons;

}


@AuraEnabled
public static void cancelTicket(String fle){

 List<Flight__c> newfli=new List<Flight__c>();
   List<Flight__c> cu=[SELECT Id,Ticket_Status__c,Name FROM Flight__C WHERE Name =:fle];
   System.debug(cu);
   for(Flight__c c:cu){
    c.Ticket_Status__c='Pending Cancellation';
    newfli.add(c);
    system.debug(newfli);

   }
    update newfli;
}
    }

