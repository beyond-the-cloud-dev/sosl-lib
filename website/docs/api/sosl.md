---
sidebar_position: 1
---

# SOSL

The lib main class for query construction.

## Methods

The following are methods for `SOSL`.

[**FIND**](#select)

- [`find(String searchText)`](#find)

**IN**

- [`inAllFields()`](#inallfields)
- [`inNameFields()`](#innamefields)
- [`inEmailFields()`](#inemailfields)
- [`inPhoneFields()`](#inphonefields)
- [`inSidebarFields()`](#insidebarfields)

[**RETURNING**](#returning)

- [`returning(IReturning returning)`](#returning)

[**WITH**](#using-scope)

- [`withDivision(String division)`](#delegatedscope)
- [`withHighlight()`](#delegatedscope)
- [`withSnippet(Integer targetLength)`](#delegatedscope)
- [`withNetworkEqual(Id networkId)`](#delegatedscope)
- [`withNetworkIn(Iterable<Id> networkIds)`](#delegatedscope)
- [`withPriceBookId(Id priceBookId)`](#delegatedscope)
- [`withMetadata(String metadata)`](#delegatedscope)
- [`withSpellCorrection()`](#delegatedscope)
- [`withoutSpellCorrection()`](#delegatedscope)

[**LIMIT**](#limit)

- [`setLimit(Integer amount)`](#setlimit)

[**UPDATE**](#offset)

- [`updateViewStat()`](#offset)
- [`updateTracking()`](#offset)

[**FIELD-LEVEL SECURITY**](#field-level-security)

- [`systemMode()`](#systemmode)

[**SHARING MODE**](#sharing-mode)

- [`withSharing()`](#withsharing)
- [`withoutSharing()`](#withoutsharing)

[**DEBUGGING**](#debugging)

- [`preview()`](#preview)

[**RESULT**](#result)

- [`toSearchList()`](#doexist)
- [`toSearchResult`](#tovalueof)

## FIND

**Signature**

```apex
SOSL find(String searchText)
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS
```
```apex
SOSL.find('MySearch').inAllFields().toSearchList();
```

## IN

### inAllFields

**Signature**

```apex
SOSL inAllFields()
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS
```
```apex
SOSL.find('MySearch').inAllFields().toSearchList();
```

### inNameFields

**Signature**

```apex
SOSL inNameFields()
```

**Example**

```sql
FIND 'MySearch' IN NAME FIELDS
```
```apex
SOSL.find('MySearch').inNameFields().toSearchList();
```

### inEmailFields

**Signature**

```apex
SOSL inEmailFields()
```

**Example**

```sql
FIND 'MySearch' IN EMAIL FIELDS
```
```apex
SOSL.find('MySearch').inEmailFields().toSearchList();
```

### inPhoneFields

**Signature**

```apex
SOSL inPhoneFields()
```

**Example**

```sql
FIND 'MySearch' IN PHONE FIELDS
```
```apex
SOSL.find('MySearch').inPhoneFields().toSearchList();
```

### inSidebarFields

**Signature**

```apex
SOSL inSidebarFields()
```

**Example**

```sql
FIND 'MySearch' IN SIDEBAR FIELDS
```
```apex
SOSL.find('MySearch').inSidebarFields().toSearchList();
```

## RETURNING

For more details check [RETURNING API](./sosl-returning.md).

**Signature**

```apex
FIND 'MySearch' IN ALL FIELDS RETURNING Account
```

**Example**

```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .toSearchList();
```

## USING SCOPE

[USING SCOPE](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_using_scope.htm)

### delegatedScope

> Filter for records delegated to another user for action. For example, a query could filter for only delegated Task records.

**Signature**

```apex
SOSL delegatedScope()
```

**Example**

```sql
SELECT Id
FROM Task
USING SCOPE DELEGATED
```
```apex
SOSL.of(Task.SObjectType)
    .delegatedScope()
    .toList();
```

### mineScope

> Filter for records owned by the user running the query.

**Signature**

```apex
SOSL mineScope()
```

**Example**

```sql
SELECT Id
FROM Task
USING SCOPE MINE
```
```apex
SOSL.of(Account.SObjectType)
    .mineScope()
    .toList();
```

### mineAndMyGroupsScope

> Filter for records assigned to the user running the query and the user’s queues. If a user is assigned to a queue, the user can access records in the queue. This filter applies only to the ProcessInstanceWorkItem object.

**Signature**

```apex
SOSL mineAndMyGroupsScope()
```

**Example**

```sql
SELECT Id
FROM Task
USING SCOPE MINE_AND_MY_GROUPS
```
```apex
SOSL.of(ProcessInstanceWorkItem.SObjectType)
    .mineAndMyGroupsScope()
    .toList();
```

### myTerritoryScope

> Filter for records in the territory of the user running the query. This option is available if territory management is enabled for your organization.

**Signature**

```apex
SOSL myTerritoryScope()
```

**Example**

```sql
SELECT Id
FROM Opportunity
USING SCOPE MY_TERRITORY
```
```apex
SOSL.of(Opportunity.SObjectType)
    .myTerritoryScope()
    .toList();
```

### myTeamTerritoryScope

> Filter for records in the territory of the team of the user running the query. This option is available if territory management is enabled for your organization.

**Signature**

```apex
SOSL myTeamTerritoryScope()
```

**Example**

```sql
SELECT Id
FROM Opportunity
USING SCOPE MY_TEAM_TERRITORY
```
```apex
SOSL.of(Opportunity.SObjectType)
    .myTeamTerritoryScope()
    .toList();
```

### teamScope

> Filter for records assigned to a team, such as an Account team.

**Signature**

```apex
SOSL teamScope()
```

**Example**

```sql
SELECT Id FROM Account USING SCOPE TEAM
```
```apex
SOSL.of(Account.SObjectType)
    .teamScope()
    .toList();
```

## WHERE

### whereAre

[WHERE](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_conditionexpression.htm)

> The condition expression in a `WHERE` clause of a SOSL query includes one or more field expressions. You can specify multiple field expressions in a condition expression by using logical operators.

For more details check [`SOSL.FilterGroup`](sosl-filters-group.md) and [`SOSL.Filter`](sosl-filter.md)

**Signature**

```apex
SOSL whereAre(FilterClause conditions)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Id = :accountId OR Name = '%MyAccount%'
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.Id).equal(accountId))
        .add(SOSL.Filter.with(Account.Name).contains('MyAccount'))
        .conditionLogic('1 OR 2')
    ).toList();
```

### whereAre string

Execute conditions passed as String.

**Signature**

```apex
SOSL whereAre(String conditions)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE NumberOfEmployees >=10 AND NumberOfEmployees <= 20
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre('NumberOfEmployees >=10 AND NumberOfEmployees <= 20')
    .toList();
```

### conditionLogic

Set conditions order for SOSL query. When not specify all conditions will be with `AND`.

**Signature**

```apex
SOSL conditionLogic(String order)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = 'Test' AND BillingCity = 'Krakow'
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.Name).equal('Test'))
    .whereAre(SOSL.Filter.with(Account.BillingCity).equal('Krakow'))
    .conditionLogic('1 OR 2')
    .toList();
```

### anyConditionMatching

When the [conditionLogic](#conditionlogic) is not specified, all conditions are joined using the `AND` operator by default.

To change the default condition logic, you can utilize the `anyConditionMatching` method, which joins conditions using the `OR` operator.

**Signature**

```apex
SOSL anyConditionMatching()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = 'Test' AND BillingCity = 'Krakow'
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.Name).equal('Test'))
    .whereAre(SOSL.Filter.with(Account.BillingCity).equal('Krakow'))
    .anyConditionMatching()
    .toList();
```

## GROUP BY

[GROUP BY](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_groupby.htm)
### groupBy

> You can use the `GROUP BY` option in a SOSL query to avoid iterating through individual query results. That is, you specify a group of records instead of processing many individual records.

**Signature**

```apex
SOSL groupBy(SObjectField field)
```

**Example**

```sql
SELECT LeadSource
FROM Lead
GROUP BY LeadSource
```
```apex
SOSL.of(Lead.SObjectType)
    .with(Lead.LeadSource)
    .groupBy(Lead.LeadSource)
    .toAggregated();
```

### groupByRollup

**Signature**

```apex
SOSL groupByRollup(SObjectField field)
```

**Example**

```sql
SELECT LeadSource, COUNT(Name) cnt
FROM Lead
GROUP BY ROLLUP(LeadSource)
```
```apex
QS.of(Lead.SObjectType)
    .with(Lead.LeadSource)
    .count(Lead.Name, 'cnt')
    .groupByRollup(Lead.LeadSource)
    .toAggregated();
```

## ORDER BY

[ORDER BY](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_orderby.htm)

### orderBy

> Use the optional `ORDER BY` in a `SELECT` statement of a SOSL query to control the order of the query results.

**Signature**

```apex
SOSL orderBy(SObjectField field)
SOSL orderBy(String field)
SOSL orderBy(String field, String direction)
```

**Example**

```sql
SELECT Id
FROM Account
ORDER BY Name DESC
```
```apex
SOSL.of(Account.SObjectType)
    .orderBy(Account.Name)
    .sortDesc()
    .toList();

SOSL.of(Account.SObjectType)
    .orderBy('Name')
    .sortDesc()
    .toList();

SOSL.of(Account.SObjectType)
    .orderBy('Name', 'DESC')
    .toList();
```

### orderBy related

Order SOSL query by parent field.

**Signature**

```apex
SOSL orderBy(String relationshipName, SObjectField field)
```

**Example**

```sql
SELECT Id
FROM Contact
ORDER BY Account.Name
```
```apex
SOSL.of(Contact.SObjectType)
    .orderBy('Account', Account.Name)
    .toList();
```

### sortDesc

Default order is ascending (`ASC`).

**Signature**

```apex
SOSL sortDesc()
```

**Example**

```sql
SELECT Id
FROM Account
ORDER BY Name DESC
```
```apex
SOSL.of(Account.SObjectType)
    .orderBy(Account.Name)
    .sortDesc()
    .toList();
```

### nullsLast

By default, null values are sorted first (`NULLS FIRST`).

**Signature**

```apex
SOSL nullsLast()
```

**Example**

```sql
SELECT Id
FROM Account
ORDER BY Name NULLS LAST
```
```apex
SOSL.of(Account.SObjectType)
    .orderBy(Account.Industry)
    .nullsLast()
    .toList();
```

## LIMIT
### setLimit

- [LIMIT](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_limit.htm)

> `LIMIT` is an optional clause that can be added to a `SELECT` statement of a SOSL query to specify the maximum number of rows to return.

**Signature**

```apex
SOSL setLimit(Integer amount)
```

**Example**

```sql
SELECT Id
FROM Account
LIMIT 100
```
```apex
SOSL.of(Account.SObjectType)
    .setLimit(100)
    .toList();
```

## OFFSET
### offset

- [OFFSET](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_offset.htm)

> When expecting many records in a query’s results, you can display the results in multiple pages by using the `OFFSET` clause on a SOSL query.

**Signature**

```apex
SOSL offset(Integer startingRow)
```

**Example**

```sql
SELECT Id
FROM Account
OFFSET 10
```
```apex
SOSL.of(Account.SObjectType)
    .setOffset(10)
    .toList();
```

## FOR

- [FOR VIEW and FOR REFERENCE](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_for_view_for_reference.htm)
- [FOR UPDATE](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_for_update.htm)
### forReference

> Use to notify Salesforce when a record is referenced from a custom interface, such as in a mobile application or from a custom page.

**Signature**

```apex
SOSL forReference()
```

**Example**

```sql
SELECT Id
FROM Contact
FOR REFERENCE
```
```apex
SOSL.of(Contact.SObjectType)
    .forReference()
    .toList();
```

### forView

> Use to update objects with information about when they were last viewed.

**Signature**

```apex
SOSL forView()
```

**Example**

```sql
SELECT Id
FROM Contact
FOR VIEW
```
```apex
SOSL.of(Contact.SObjectType)
    .forView()
    .toList();
```

### forUpdate

> Use to lock sObject records while they’re being updated in order to prevent race conditions and other thread safety problems.

**Signature**

```apex
SOSL forUpdate()
```

**Example**

```sql
SELECT Id
FROM Contact
FOR UPDATE
```
```apex
SOSL.of(Contact.SObjectType)
    .forUpdate()
    .toList();
```

### allRows

> SOSL statements can use the ALL ROWS keywords to query all records in an organization, including deleted records and archived activities.

**Signature**

```apex
SOSL allRows()
```

**Example**

```sql
SELECT COUNT()
FROM Contact
ALL ROWS
```
```apex
SOSL.of(Contact.SObjectType)
    .count()
    .allRows()
    .toList();
```

## FIELD-LEVEL SECURITY

[AccessLevel Class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_class_System_AccessLevel.htm#apex_class_System_AccessLevel)

By default AccessLevel is set as `USER_MODE`.

More details you can find in [here](../advanced-usage/fls.md)

### systemMode

> Execution mode in which the the object and field-level permissions of the current user are ignored, and the record sharing rules are controlled by the class sharing keywords.

**Signature**

```apex
SOSL systemMode()
```

**Example**

```apex
SOSL.of(Account.SObjectType)
    .systemMode()
    .toList();
```

### stripInaccessible

`USER_MODE` enforces not only object and field-level security but also sharing rules (`with sharing`). You may encounter situations where you need object and field-level security but want to ignore sharing rules (`without sharing`). To achieve this, use `.systemMode()`, `.withoutSharing()` and `.stripInaccessible()`.

Read more about `stripInaccessible` in [advanced](../advanced-usage/fls.md#strip-inaccessible).

**Signature**

```apex
SOSL stripInaccessible()
SOSL stripInaccessible(AccessType accessType)
```

```apex
SOSL.of(Account.SObjectType)
    .systemMode()
    .withoutSharing()
    .stripInaccessible()
    .toList();
```

## SHARING MODE

[Using the with sharing, without sharing, and inherited sharing Keywords](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_sharing.htm)

More details you can find in [here](../advanced-usage/sharing.md).

### withSharing

Execute query `with sharing`.

**Note!** System mode needs to be enabled by `.systemMode()`.

**Signature**

```apex
SOSL withSharing()
```

**Example**

```apex
SOSL.of(Account.SObjectType)
    .systemMode()
    .withSharing()
    .toList();
```

### withoutSharing

Execute query `without sharing`.

**Note!** System mode needs to be enabled by `.systemMode()`.

**Signature**

```apex
SOSL withoutSharing()
```

**Example**

```apex
SOSL.of(Account.SObjectType)
    .systemMode()
    .withoutSharing()
    .toList();
```

## MOCKING

### mockId

Query needs unique id that allows for mocking.

**Signature**

```apex
SOSL mockId(String queryIdentifier)
```

**Example**

```apex
SOSL.of(Account.SObjectType)
    .mockId('MyQuery')
    .toList();

// In Unit Test
SOSL.setMock('MyQuery', new List<Account>{
    new Account(Name = 'MyAccount 1'),
    new Account(Name = 'MyAccount 2')
});
```

### record mock

**Signature**

```apex
SOSL setMock(String mockId, SObject record)
```

**Example**

```apex
SOSL.of(Account.sObjectType)
    .mockId('MyQuery')
    .toList();

// In Unit Test
SOSL.setMock('MyQuery', new Account(Name = 'MyAccount 1'));
```

### list mock

**Signature**

```apex
SOSL setMock(String mockId, List<SObject> records)
```

**Example**

```apex
SOSL.of(Account.sObjectType)
    .mockId('MyQuery')
    .toList();

// In Unit Test
SOSL.setMock('MyQuery', new List<Account>{
    new Account(Name = 'MyAccount 1'),
    new Account(Name = 'MyAccount 2')
});
```

### count mock

**Signature**

```apex
SOSL setCountMock(String mockId, Integer amount)
```

**Example**

```apex
SOSL.of(Account.sObjectType)
    .mockId('MyQuery')
    .count()
    .toInteger();

// In Unit Test
SOSL.setMock('MyQuery', 5);
```

## DEBUGGING
### preview

**Signature**

```apex
SOSL preview()
```

**Example**

```apex
SOSL.of(Account.SObjectType)
    .preview()
    .toList();
```

Query preview will be available in debug logs:

```
============ Query Preview ============
SELECT Name, AccountNumber, BillingCity, BillingCountry, BillingCountryCode
FROM Account
WHERE ((Id = :v1 OR Name LIKE :v2))
=======================================

============ Query Binding ============
{
  "v2" : "%Test%",
  "v1" : "0013V00000WNCw4QAH"
}
=======================================
```

## PREDEFINIED

For all predefined methods SOSL instance is returned so you can still adjust query before execution.
Add additional fields with [`.with`](#select).

### byId

**Signature**

```apex
SOSL byId(Id recordId)
```

```apex
SOSL byId(SObject record)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Id = '1234'
```
```apex
SOSL.of(Account.SObjectType)
    .byId('1234')
    .toObject();
```
```apex
Account account = [SELECT Id FROM Account LIMIT 1];
SOSL.of(Account.SObjectType)
    .byId(account)
    .toList();
```

### byIds

**Signature**


```apex
SOSL byIds(Iterable<Id> recordIds)
```

```apex
SOSL byIds(List<SObject> records)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Id IN ('1234')
```

```apex
SOSL.of(Account.SObjectType)
    .byIds(new Set<Id>{ '1234' })
    .toList();
```

```apex
SOSL.of(Account.SObjectType)
    .byIds(new List<Id>{ '1234' })
    .toList();
```

```apex
List<Account> accounts = [SELECT Id FROM Account];
SOSL.of(Account.SObjectType)
    .byIds(accounts)
    .toList();
```

## RESULT

### doExist

```apex
Boolean doExist()
```

**Example**

```apex
Boolean isRecordExist = SOSL.of(Account.SObjectType).byId('1234').doExist();
```

### toValueOf

Extract field value from query result.
Field will be automatically added to the query fields.

**Signature**

```apex
Object toValueOf(SObjectField fieldToExtract)
```

**Example**

```apex
String accountName = (String) SOSL.of(Account.SObjectType).byId('1234').toValueOf(Account.Name)
```

### toValuesOf

Extract field values from query result.
Field will be automatically added to the query fields.

SOSL Lib is using [Building a KeySet from any field](https://salesforce.stackexchange.com/questions/393308/get-a-list-of-one-column-from-a-sosl-result) approach to get only one field.

Note! It does not work with Custom Metadata.

**Signature**

```apex
Set<String> toValuesOf(SObjectField fieldToExtract)
```

**Example**

```apex
Set<String> accountNames = SOSL.of(Account.SObjectType).byId('1234').toValuesOf(Account.Name)
```

### toInteger

**Signature**

```apex
Integer toInteger()
```

**Example**

```sql
SELECT COUNT() FROM Account
```
```apex
SOSL.of(Account.SObjectType).count().toInteger();
```

### toObject

When list of records is greater than 1 the `List has more than 1 row for assignment to SObject` will occur.

When there is no record to assign the `List has no rows for assignment to SObject` will occur.

**Signature**

```apex
sObject toObject()
```

**Example**

```apex
SOSL.of(Account.SObjectType).toObject();
```

### toList

**Signature**

```apex
List<sObject> toList()
```

**Example**

```apex
SOSL.of(Account.SObjectType).toList();
```

### toAggregated

**Signature**

```apex
List<AggregateResult> toAggregated()
```

**Example**


```sql
SELECT LeadSource
FROM Lead
GROUP BY LeadSource
```

```apex
SOSL.of(Lead.SObjectType)
    .with(Lead.LeadSource)
    .groupBy(Lead.LeadSource)
    .toAggregated()
```

### toMap

**Signature**

```apex
Map<Id, SObject> toMap()
```

**Example**

```apex
SOSL.of(Account.SObjectType).toMap();
```

### toQueryLocator

**Signature**

```apex
Database.QueryLocator toQueryLocator()
```

**Example**

```apex
SOSL.of(Account.SObjectType).toQueryLocator();
```
