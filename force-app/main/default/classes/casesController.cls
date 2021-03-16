public with sharing class casesController {
    public casesController() {

    }
    @AuraEnabled
    public static List<Case> getCases(){
        List<Case> cons = [SELECT Id, CaseNumber, ContactId,Status,Subject,Comments FROM Case ];

    return cons;
    }
}
