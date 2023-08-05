public with sharing class SOSL_Test {
    public SOSL_Test() {

    }

    SOSL.Result result = SOSL.find('Joe Smith')

    .inAllFields()
    .inNameFields()
    .inEmailFields()
    .inPhoneFields()
    .inSidebarFields()

    .returning(Account.SObjectType).with(Account.Name).setLimit(10)
    .returning(Contact.SObjectType).with(Contact.FirstName, Contact.LastName).setLimit(10)
    // OR
    .returning(
        SOSL.Returning(Account.SObjectType)
            .with(Account.Name)
            .setLimit(10)
    )
    .returning(
        SOSL.Returning(Contact.SObjectType)
            .with(Contact.FirstName, Contact.LastName)
            .setLimit(20)
    )

    .search();

    List<Account> accounts = result.get(Account.SObject);
    List<Contact> contacts = result.get(Contact.SObject);

}



System.debug(LoggingLevel.DEBUG, ': ' + SOSL.find('Joe Smith').inAllFields().toString());
