public with sharing class FlightWrapper {
    public FlightWrapper() {

    }
    @AuraEnabled public Integer MinPrice{get; set;}
    @AuraEnabled public String departureDate{get; set;}
    @AuraEnabled public String CarrierName{get; set;}
    @AuraEnabled public String orgAirport{get; set;}
    @AuraEnabled public String orgAirportAlias{get; set;}
    @AuraEnabled public String orgCityName{get; set;}
    @AuraEnabled public String orgCountryName{get; set;}
    @AuraEnabled public String desAirport{get; set;}
    @AuraEnabled public String desAirportAlias{get; set;}
    @AuraEnabled public String desCityName{get; set;}
    @AuraEnabled public String desCountryName{get; set;}






    
}
