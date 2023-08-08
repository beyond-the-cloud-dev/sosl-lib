/**
 * Copyright (c) 2023 BeyondTheCloud.Dev
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/soql-lib/blob/main/LICENSE)
 *
 * PMD False Positives:
 * - CyclomaticComplexity: It is a library and we tried to put everything into ONE test class
 * - CognitiveComplexity: It is a library and we tried to put everything into ONE class
 * - ApexDoc: Variable names are self-documented.
**/
@SuppressWarnings('PMD.CyclomaticComplexity, PMD.CognitiveComplexity, PMD.ApexDoc')
@IsTest
private class SOSL_Test {
    private static final String SEARCH_TEXT = 'SearchText';

    @IsTest
    static void soslFind() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account', sosl.toString());
    }

    @IsTest
    static void soslInAllFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account', sosl.toString());
    }

    @IsTest
    static void soslInNameFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inNameFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN NAME FIELDS RETURNING Account', sosl.toString());
    }

    @IsTest
    static void soslInEmailFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inEmailFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN EMAIL FIELDS RETURNING Account', sosl.toString());
    }

    @IsTest
    static void soslInPhoneFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inPhoneFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN PHONE FIELDS RETURNING Account', sosl.toString());
    }

    @IsTest
    static void soslInSidebarFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inSidebarFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN SIDEBAR FIELDS RETURNING Account', sosl.toString());
    }

    @IsTest
    static void soslReturning() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account', sosl.toString());
    }

    @IsTest
    static void returningWithField() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id)', sosl.toString());
    }

    @IsTest
    static void returningWithTwoFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name)', sosl.toString());
    }

    @IsTest
    static void returningWithThreeFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name, Account.Industry)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name, Industry)', sosl.toString());
    }

    @IsTest
    static void returningWithFourFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name, Account.Industry, Account.AccountSource)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name, Industry, AccountSource)', sosl.toString());
    }

    @IsTest
    static void returningWithFiveFields() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name, Account.Industry, Account.AccountSource, Account.BillingCity)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name, Industry, AccountSource, BillingCity)', sosl.toString());
    }

    @IsTest
    static void filterId() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.id().isNotNull())
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Id != null)', sosl.toString());
    }

    @IsTest
    static void filterRecordType() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.recordType().equal('Partner'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE RecordType.DeveloperName = \'Partner\')', sosl.toString());
    }

    @IsTest
    static void filterName() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.name().equal('Test'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Name = \'Test\')', sosl.toString());
    }

    @IsTest
    static void filterWith() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).equal('IT'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry = \'IT\')', sosl.toString());
    }

    @IsTest
    static void filterWithRelated() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Contact.SObjectType)
                    .with(Contact.Id, Contact.Name)
                    .whereAre(SOSL.Filter.with('Account', Account.Industry).equal('IT'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Contact(Id, Name WHERE Account.Industry = \'IT\')', sosl.toString());
    }

    @IsTest
    static void filterWithString() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with('Industry').equal('IT'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry = \'IT\')', sosl.toString());
    }

    @IsTest
    static void filterIsNull() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).isNull())
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry = null)', sosl.toString());
    }

    @IsTest
    static void filterIsNotNull() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).isNotNull())
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry != null)', sosl.toString());
    }

    @IsTest
    static void filterIsTrue() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.IsDeleted).isTrue())
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE IsDeleted = true)', sosl.toString());
    }

    @IsTest
    static void filterIsFalse() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.IsDeleted).isFalse())
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE IsDeleted = false)', sosl.toString());
    }

    @IsTest
    static void filterEqualInteger() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).equal(10))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE NumberOfEmployees = 10)', sosl.toString());
    }

    @IsTest
    static void filterEqualString() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Name).equal('My Account'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Name = \'My Account\')', sosl.toString());
    }

    @IsTest
    static void filterNotEqualInteger() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).notEqual(10))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE NumberOfEmployees != 10)', sosl.toString());
    }

    @IsTest
    static void filterNotEqualString() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Name).notEqual('My Account'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Name != \'My Account\')', sosl.toString());
    }

    @IsTest
    static void filterLessThan() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).lessThan(10))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE NumberOfEmployees < 10)', sosl.toString());
    }

    @IsTest
    static void filterGreaterThan() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).greaterThan(10))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE NumberOfEmployees > 10)', sosl.toString());
    }

    @IsTest
    static void filterLessOrEqual() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).lessOrEqual(10))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE NumberOfEmployees <= 10)', sosl.toString());
    }

    @IsTest
    static void filterGreaterOrEqual() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).greaterOrEqual(10))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE NumberOfEmployees >= 10)', sosl.toString());
    }

    @IsTest
    static void filterContainsSome() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Name).containsSome(new List<String>{ 'Test'}))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Name LIKE (\'Test\'))', sosl.toString());
    }

    @IsTest
    static void filterContains() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Name).contains('Test'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Name LIKE \'%Test%\')', sosl.toString());
    }

    @IsTest
    static void filterStartWith() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Name).startsWith('Test'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Name LIKE \'Test%\')', sosl.toString());
    }

    @IsTest
    static void filterEndsWith() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Name).endsWith('Test'))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Name LIKE \'%Test\')', sosl.toString());
    }

    @IsTest
    static void filterIsIn() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).isIn(new List<String>{ 'IT' }))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry IN (\'IT\'))', sosl.toString());
    }

    @IsTest
    static void filterNotIn() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).notIn(new List<String>{ 'IT' }))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry NOT IN (\'IT\'))', sosl.toString());
    }

    @IsTest
    static void returningWithFilterGroup() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.FilterGroup
                        .add(SOSL.Filter.with(Account.Name).equal('MyAccount'))
                        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
                    )
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE (Name = \'MyAccount\' AND Industry = \'IT\'))', sosl.toString());
    }

    @IsTest
    static void filterGroupAnyConditionMatching() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.FilterGroup
                        .add(SOSL.Filter.with(Account.Name).equal('MyAccount'))
                        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
                        .anyConditionMatching()
                    )
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE (Name = \'MyAccount\' OR Industry = \'IT\'))', sosl.toString());
    }

    @IsTest
    static void filterGroupAddNestedGroup() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.FilterGroup
                        .add(SOSL.Filter.with(Account.Name).equal('MyAccount'))
                        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
                        .add(SOSL.FilterGroup
                            .add(SOSL.Filter.with(Account.NumberOfEmployees).greaterThan(5))
                            .add(SOSL.Filter.with(Account.IsDeleted).isFalse())
                            .anyConditionMatching()
                        )
                    )
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE (Name = \'MyAccount\' AND Industry = \'IT\' AND (NumberOfEmployees > 5 OR IsDeleted = false)))', sosl.toString());
    }

    @IsTest
    static void filterGroupAddDynamicondition() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.FilterGroup
                        .add('Name = \'MyAccount\'')
                    )
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE (Name = \'MyAccount\'))', sosl.toString());
    }

    @IsTest
    static void filterGroupConditionLogic() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.FilterGroup
                        .add(SOSL.Filter.with(Account.Name).equal('MyAccount'))
                        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
                        .conditionLogic('1 OR 2')
                    )
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE (Name = \'MyAccount\' OR Industry = \'IT\'))', sosl.toString());
    }

    @IsTest
    static void returningSetLimit() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .setLimit(100)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name LIMIT 100)', sosl.toString());
    }

    @IsTest
    static void returningOffset() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .offset(100)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name OFFSET 100)', sosl.toString());
    }

    @IsTest
    static void soslWithDivision() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withDivision('Global');

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH DIVISION = \'Global\'', sosl.toString());
    }

    // @IsTest
    // static void soslWithSnippet() {
    //     // Test
    //     SOSL sosl = SOSL.find(SEARCH_TEXT)
    //         .inAllFields()
    //         .returning(
    //             SOSL.Returning(Account.SObjectType)
    //         )
    //         .withSnippet('Global');

    //     // Verify
    //     Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH DIVISION = \'Global\'', sosl.toString());
    // }

    @IsTest
    static void soslWithNetworkIdEqual() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withNetworkEqual('0013V00000WNCwCQAX');

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH NETWORK = \'0013V00000WNCwCQAX\'', sosl.toString());
    }
}
