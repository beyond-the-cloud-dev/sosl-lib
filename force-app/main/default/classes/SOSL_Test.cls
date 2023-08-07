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
    static void find() {
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
    static void inAllFields() {
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
    static void inNameFields() {
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
    static void inEmailFields() {
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
    static void inPhoneFields() {
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
    static void inSidebarFields() {
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
    static void returning() {
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
    static void id() {
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
    static void recordType() {
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
    static void name() {
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
    static void with() {
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
}
