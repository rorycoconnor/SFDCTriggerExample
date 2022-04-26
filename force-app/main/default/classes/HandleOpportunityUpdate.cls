public with sharing class HandleOpportunityUpdate {
    @future(callout=true)
    public static void HandleOpportunityUpdate(Id oppId) {
        //Instantiate the Box Toolkit
        box.Toolkit toolkit = new box.Toolkit();

        //Get parent folder Id from FRUP Table
        box__FRUP__c frup = [SELECT box__Folder_ID__c from box__FRUP__c where box__Record_ID__c = :oppId LIMIT 1];
        String folderId = frup.box__Folder_ID__c;

        //Create a new folder called High Value Deal Assets
        String newFolderID = toolkit.createFolder('High Value Deal Assets', folderId, null);

        //Make the JSON object that includes the Request Body
        String obj = '{"id":' + newFolderID + '}';

        //Compile the API Request into a single object
        Map<String, Object> metadata = new Map<String, Object>{
            'parent' => JSON.deserializeUntyped(obj)
        };


        //Structure the request to copy Guide file into the new folder
        String endpoint = 'https://api.box.com/2.0/files/950293053534/copy';
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(endpoint);
        request.setBody(JSON.serialize(metadata));
        request.setHeader('content-type', 'application/json');

        //Make request
        HttpResponse response = toolkit.sendRequest(request);
    }
}
