/**
 * Copyright (c) 2023 BeyondTheCloud.Dev
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/sosl-lib/blob/main/LICENSE)
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
    private static final String FAKE_ID = '0013V00000WNCwCQAX';

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
    static void returningWithFieldsList() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(new List<SObjectField>{
                        Account.Id, Account.Name, Account.Industry, Account.AccountSource, Account.BillingCity, Account.NumberOfEmployees
                     })
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name, Industry, AccountSource, BillingCity, NumberOfEmployees)', sosl.toString());
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
    static void filterIsInListOfStrings() {
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
    static void filterIsInListOfIntegers() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).isIn(new List<Integer>{ 10, 20, 30 }))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE NumberOfEmployees IN (10, 20, 30))', sosl.toString());
    }

    @IsTest
    static void filterNotInListOfStrings() {
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
    static void filterIsNotInListOfIntegers() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).notIn(new List<Integer>{ 10, 20, 30 }))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE NumberOfEmployees NOT IN (10, 20, 30))', sosl.toString());
    }

    @IsTest
    static void filterIncludesAll() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).includesAll(new List<String>{ 'IT', 'Tech' }))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry INCLUDES (\'IT;Tech\'))', sosl.toString());
    }

    @IsTest
    static void filterIncludesSome() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).includesSome(new List<String>{ 'IT', 'Tech' }))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry INCLUDES (\'IT\', \'Tech\'))', sosl.toString());
    }

    @IsTest
    static void filterExcludesAll() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).excludesAll(new List<String>{ 'IT', 'Tech' }))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry EXCLUDES (\'IT\', \'Tech\'))', sosl.toString());
    }

    @IsTest
    static void filterExcludesSome() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.Filter.with(Account.Industry).excludesSome(new List<String>{ 'IT', 'Tech' }))
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE Industry EXCLUDES (\'IT;Tech\'))', sosl.toString());
    }

    @IsTest
    static void filterIgnoreWhen() {
        // Setup
        String accountName = '';

        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.FilterGroup
                        .add(SOSL.Filter.with(Account.Name).equal(accountName).ignoreWhen(String.isEmpty(accountName)))
                        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
                    )
            );

         // Verify
         Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name WHERE (Industry = \'IT\'))', sosl.toString());
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

    @isTest
    static void filterGroupEmptyFilterGroup() {
                // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .whereAre(SOSL.FilterGroup)
            );

        // Verify
         Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name)', sosl.toString());
    }

    @isTest
    static void filterGroupEmptyDynamicFilter() {
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
    static void returningUsingListView() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .usingListView('Recent')
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name USING LISTVIEW = Recent)', sosl.toString());
    }

    @IsTest
    static void returningOrderByStringField() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .orderBy('Name')
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name ORDER BY Name ASC NULLS FIRST)', sosl.toString());
    }

    @IsTest
    static void returningOrderByStringFieldAndDirection() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .orderBy('Name', 'DESC')
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name ORDER BY Name DESC NULLS FIRST)', sosl.toString());
    }

    @IsTest
    static void returningOrderBy() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .orderBy(Account.Name)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name ORDER BY Name ASC NULLS FIRST)', sosl.toString());
    }

    @IsTest
    static void returningOrderByRelatedField() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Contact.SObjectType)
                    .with(Contact.Id, Contact.Name)
                    .orderBy('Account', Account.Name)
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Contact(Id, Name ORDER BY Account.Name ASC NULLS FIRST)', sosl.toString());
    }

    @IsTest
    static void returningOrderByWithSortDesc() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .orderBy(Account.Name)
                    .sortDesc()
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name ORDER BY Name DESC NULLS FIRST)', sosl.toString());
    }

    @IsTest
    static void returningOrderByWithNullsLast() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
                    .with(Account.Id, Account.Name)
                    .orderBy(Account.Name)
                    .nullsLast()
            );

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account(Id, Name ORDER BY Name ASC NULLS LAST)', sosl.toString());
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

    @IsTest
    static void soslWithHighlight() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withHighlight();

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH HIGHLIGHT', sosl.toString());
    }

    @IsTest
    static void soslWithSnippet() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withSnippet(120);

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH SNIPPET (target_length=120)', sosl.toString());
    }

    @IsTest
    static void soslWithNetworkIdEqual() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withNetworkEqual(FAKE_ID);

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH NETWORK = \'0013V00000WNCwCQAX\'', sosl.toString());
    }

    @IsTest
    static void soslWithNetworkInList() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withNetworkIn(new List<Id>{ FAKE_ID });

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH NETWORK IN (\'0013V00000WNCwCQAX\')', sosl.toString());
    }

    @IsTest
    static void soslWithNetworkInSet() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withNetworkIn(new Set<Id>{ FAKE_ID });

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH NETWORK IN (\'0013V00000WNCwCQAX\')', sosl.toString());
    }

    @IsTest
    static void soslWithPriceBookId() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withPriceBookId(FAKE_ID);

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH PricebookId = \'0013V00000WNCwCQAX\'', sosl.toString());
    }

    @IsTest
    static void soslWithMetadata() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withMetadata('LABELS');

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH METADATA = \'LABELS\'', sosl.toString());
    }

    @IsTest
    static void soslWithSpellCorrection() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withSpellCorrection();

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH SPELL_CORRECTION', sosl.toString());
    }

    @IsTest
    static void soslWithoutSpellCorrection() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withoutSpellCorrection();

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account WITH SPELL_CORRECTION = false', sosl.toString());
    }

    @IsTest
    static void soslLimit() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .setLimit(200);

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account LIMIT 200', sosl.toString());
    }

    @IsTest
    static void soslUpdateViewStat() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .updateViewStat();

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account UPDATE VIEWSTAT', sosl.toString());
    }

    @IsTest
    static void soslUpdatetTracking() {
        // Test
        SOSL sosl = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .updateTracking();

        // Verify
        Assert.areEqual('FIND \'SearchText\' IN ALL FIELDS RETURNING Account UPDATE TRACKING', sosl.toString());
    }

    @IsTest
    static void toSearchListInheritedSharing() {
        // Test
        List<List<SObject>> searchList = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .toSearchList();

        // Verify
        Assert.areEqual(0, searchList[0].size());
    }

    @IsTest
    static void toSearchResultInheritedSharing() {
        // Test
        Search.SearchResults searchResults = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .withSnippet(120)
            .toSearchResult();

        // Verify
        Assert.areEqual(0, searchResults.get('Account').size());
    }

    @IsTest
    static void toSearchListWithSharing() {
        // Test
        List<List<SObject>> searchList = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .systemMode()
            .withSharing()
            .toSearchList();

        // Verify
        Assert.areEqual(0, searchList[0].size());
    }

    @IsTest
    static void toSearchResultWithSharing() {
        // Test
        Search.SearchResults searchResults = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .systemMode()
            .withSharing()
            .withSnippet(120)
            .toSearchResult();

        // Verify
        Assert.areEqual(0, searchResults.get('Account').size());
    }

    @IsTest
    static void toSearchListWithoutSharing() {
        // Test
        List<List<SObject>> searchList = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .systemMode()
            .withoutSharing()
            .toSearchList();

        // Verify
        Assert.areEqual(0, searchList[0].size());
    }

    @IsTest
    static void toSearchResultWithoutSharing() {
        // Test
        Search.SearchResults searchResults = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .systemMode()
            .withoutSharing()
            .withSnippet(120)
            .toSearchResult();

        // Verify
        Assert.areEqual(0, searchResults.get('Account').size());
    }

    @IsTest
    static void preview() {
        // Test
        SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(
                SOSL.Returning(Account.SObjectType)
            )
            .preview();
    }

    @IsTest
    static void mock() {
        // Test
        List<SObject> testAccounts = new List<Account>{ new Account(Name = 'Mock') };
        SOSL.setMock('MockingExample', new List<List<SObject>>{ testAccounts });

        List<List<SObject>> results = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(SOSL.returning(Account.SObjectType))
            .mockId('MockingExample')
            .preview()
            .toSearchList();

        // Verify
        Assert.isFalse(results.isEmpty(), 'Should return results for at least one SObject');
        Assert.isFalse(results.get(0).isEmpty(), 'Accounts list shouldnt be empty');
        Assert.isNotNull(results.get(0).get(0), 'Account should be returned');
        Assert.areEqual(((Account) testAccounts.get(0)).Name, ((Account) results.get(0).get(0)).Name, 'Accounts name should be equal');
    }

    @IsTest
    static void mockFixedIds() {
        // Test
        List<Account> testAccounts = new List<Account>{ new Account(Name = SEARCH_TEXT) };
        insert testAccounts;

        SOSL.setMock('MockingExample', new List<Id>{ testAccounts.get(0).Id });

        List<List<SObject>> results;
        Test.startTest();
        results = SOSL.find(SEARCH_TEXT)
            .inAllFields()
            .returning(SOSL.returning(Account.SObjectType).with(Account.Name))
            .mockId('MockingExample')
            .preview()
            .toSearchList();
        Test.stopTest();

        // Verify
        List<Account> fixedAccounts = [SELECT Name FROM Account];
        Assert.isFalse(results.isEmpty(), 'Should return results for at least one SObject');
        Assert.isFalse(results.get(0).isEmpty(), 'Accounts list shouldnt be empty');
        Assert.isNotNull(results.get(0).get(0), 'Account should be returned');
        Assert.areEqual(((Account) fixedAccounts.get(0)).Name, ((Account) results.get(0).get(0)).Name, 'Accounts name should be equal');
    }
}
