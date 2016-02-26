# Template Healthcare FHIR to Salesforce Health Cloud EHR System API

+ [License Agreement](#licenseagreement)
+ [Use Case](#usecase)
+ [Considerations](#considerations)
	* [Salesforce Considerations](#salesforceconsiderations)
	* [Cloudhub security considerations](#cloudhubsecurityconsiderations)
+ [Run it!](#runit)
	* [Running on premise](#runonopremise)
	* [Running on Studio](#runonstudio)
	* [Running on Mule ESB stand alone](#runonmuleesbstandalone)
	* [Running on CloudHub](#runoncloudhub)
	* [Deploying your Anypoint Template on CloudHub](#deployingyouranypointtemplateoncloudhub)
	* [Properties to be configured (With examples)](#propertiestobeconfigured)
+ [API Calls](#apicalls)

# License Agreement <a name="licenseagreement"/>
Note that using this template is subject to the conditions of this [License Agreement](AnypointTemplateLicense.pdf).
Please review the terms of the license before downloading and using this template. In short, you are allowed to use the template for free with Mule ESB Enterprise Edition, CloudHub, or as a trial in Anypoint Studio.

# Use Case <a name="usecase"/>

As an EHR user I want to load clinical data to Salesforce Health Cloud.

FHIR to Salesforce Health Cloud EHR System API exposing 5 endpoints which expecting data in JSON format according FHIR specification [version 1.0.2 DSTU2](https://www.hl7.org/FHIR/DSTU2/index.html) and saves them to Salesforce Healthcloud System.

FHIR to Salesforce Health Cloud EHR System API is part of Healthcare Solution and is used by HL7 to FHIR EHR Process API and Salesforce Health Cloud to FHIR EHR Experience API.

For each endpoint there is separate flow which handles operation over different object - **Patient**, **Condition**, **Observation**, **Medication**, **Allergy**. Endpoints are defined by RAML specification in [healthcare-fhir2sfdchealth-ehr-system-api.raml](../master/src/main/api/healthcare-fhir2sfdchealth-ehr-system-api.raml). The routing is done  through [APIkit](https://docs.mulesoft.com/anypoint-platform-for-apis/apikit-basic-anatomy).

For the Patient object the flow transform input payload to get the Patient already inserted in Salesforce Health Cloud System and then call update operation with transformed data defined as input JSON in PUT request.

Other flows transform the input payload, get the Patient from Salesforce Health Cloud System and then create new object which contain any data about Patient.



# Considerations <a name="considerations"/>

To make this Anypoint Template run, there are certain preconditions that must be considered. **Failling to do so could lead to unexpected behavior of the template.**

## Salesforce Considerations <a name="salesforceconsiderations"/>

There may be a few things that you need to know regarding Salesforce, in order for this template to work.

In order to have this template working as expected, you should be aware of your own Salesforce fields and objects configuration.

###FAQ

 - Where can I check that the field configuration for my Salesforce instance is the right one?

    [Salesforce: Checking Field Accessibility for a Particular Field][1]

- Can I modify the Field Access Settings? How?

    [Salesforce: Modifying Field Access Settings][2]


[1]: https://help.salesforce.com/HTViewHelpDoc?id=checking_field_accessibility_for_a_particular_field.htm&language=en_US
[2]: https://help.salesforce.com/HTViewHelpDoc?id=modifying_field_access_settings.htm&language=en_US

## Cloudhub security considerations <a name="cloudhubsecurityconsiderations"/>

+ Placeholders ${http.port} and ${https.port} are forced by Cloudhub to be 8081 and 8082. These ports are always externally exposed. There is no way to override this behaviour
+ External endpoints with HTTPS are exposed through Cloudhub load balancer, which has Cloudhub valid SSL certificates for <appname\>.cloudhub.io URL
+ From the <appname\>.cloudhub.io URL, these endpoints can be reached using 80 and 443 ports depending on the protocol

There is a possibility to implement the security by generating own valid SSL certificate and changing the ${http.port} placeholder to ${https.port}.

# Run it! <a name="runit"/>
Simple steps to get Healthcare FHIR to Salesforce Health Cloud EHR System API running.
See below.

## Running on premise <a name="runonopremise"/>
In this section we detail the way you should run your Anypoint Template on your computer.


### Where to Download Mule Studio and Mule ESB
First thing to know if you are a newcomer to Mule is where to get the tools.

+ You can download Mule Studio from this [Location](http://www.mulesoft.com/platform/mule-studio)
+ You can download Mule ESB from this [Location](http://www.mulesoft.com/platform/soa/mule-esb-open-source-esb)

### Importing an Anypoint Template into Studio
Mule Studio offers several ways to import a project into the workspace, for instance: 

+ Anypoint Studio generated Deployable Archive (.zip)
+ Anypoint Studio Project from External Location
+ Maven-based Mule Project from pom.xml
+ Mule ESB Configuration XML from External Location

You can find a detailed description on how to do so in this [Documentation Page](http://www.mulesoft.org/documentation/display/current/Importing+and+Exporting+in+Studio).

### Running on Studio <a name="runonstudio"/>
Once you have imported you Anypoint Template into Anypoint Studio you need to follow these steps to run it:

+ Locate the properties file `mule-app.properties`, in src/main/app
+ Complete all the properties required as per the examples in the section [Properties to be configured](#propertiestobeconfigured)
+ Once that is done, right click on you Anypoint Template project folder 
+ Hover you mouse over `"Run as"`
+ Click on  `"Mule Application"`

### Running on Mule ESB stand alone <a name="runonmuleesbstandalone"/>
Define the mule.enviroment property located in [mule-app.properties](../master/src/main/app/mule-app.properties) to load the properties from the right file. You have to complete all properties in [mule-${mule.env}.properties](../master/src/main/resources/mule-${mule.env}.properties) and [common.properties](../master/src/main/resources/common.properties)as well to run your app. 

## Running on CloudHub <a name="runoncloudhub"/>
While [creating your application on CloudHub](http://www.mulesoft.org/documentation/display/current/Hello+World+on+CloudHub) (Or you can do it later as a next step), you need to go to `"Manage Application"` > `"Properties"` to set all environment variables detailed in **Properties to be configured**.
Follow other steps defined [here](#runonpremise) and once your app is all set and started, there is no need to do anything else.

### Deploying your Anypoint Template on CloudHub <a name="deployingyouranypointtemplateoncloudhub"/>
Mule Studio provides you with really easy way to deploy your Template directly to CloudHub, for the specific steps to do so please check this [link](http://www.mulesoft.org/documentation/display/current/Deploying+Mule+Applications#DeployingMuleApplications-DeploytoCloudHub)

## Properties to be configured (With examples) <a name="propertiestobeconfigured"/>
In order to use this Mule Anypoint Template you need to configure properties (Credentials, configurations, etc.) either in properties file or in CloudHub as Environment Variables. Detail list with examples:

### Application properties
+ http.port `8080`
+ sfdc.username `joan.baez@orgb`
+ sfdc.password `JoanBaez456`
+ sfdc.token `ces56arl7apQs56XTddf34X`

# API Calls <a name="apicalls"/>
Salesforce imposes limits on the number of API Calls that can be made.