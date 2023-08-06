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
}
