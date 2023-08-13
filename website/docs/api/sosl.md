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

[**WITH**](#with)

- [`withDivision(String division)`](#withdivision)
- [`withHighlight()`](#withhighlight)
- [`withSnippet(Integer targetLength)`](#withsnippet)
- [`withNetworkEqual(Id networkId)`](#withnetworkequal)
- [`withNetworkIn(Iterable<Id> networkIds)`](#withnetworkin)
- [`withPriceBookId(Id priceBookId)`](#withpricebookid)
- [`withMetadata(String metadata)`](#withmetadata)
- [`withSpellCorrection()`](#withspellcorrection)
- [`withoutSpellCorrection()`](#withoutspellcorrection)

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

## WITH

### withDivision

**Signature**

```apex
ISearchable withDivision(String division);
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH DIVISION = 'Global'
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withDivision('Global')
    .toSearchList();
```

### withHighlight

```apex
ISearchable withHighlight();
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH HIGHTLIGHT
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withHighlight()
    .toSearchList();
```

### withSnippet

```apex
ISearchable withSnippet(Integer targetLength);
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH SNIPPET (target_length=120)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withSnippet(120)
    .toSearchList();
```

### withNetworkEqual

```apex
ISearchable withNetworkEqual(Id networkId);
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH NETWORK = 'networkdId'
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withNetworkEqual('networkId')
    .toSearchList();
```

### withNetworkIn

```apex
ISearchable withNetworkIn(Iterable<Id> networkIds);
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH NETWORK IN ('networkdId')
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withNetworkIn(new List<Id>{ 'networkId' })
    .toSearchList();
```

### withPriceBookId

```apex
ISearchable withPriceBookId(Id priceBookId);
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH PricebookId = 'pricebookId'
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withPriceBookId('pricebookId')
    .toSearchList();
```

### withMetadata

```apex
ISearchable withMetadata(String metadata);
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH METADATA = 'LABELS'
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withMetadata('LABELS')
    .toSearchList();
```
### withSpellCorrection

```apex
ISearchable withSpellCorrection();
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH SPELL_CORRECTION
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withSpellCorrection()
    .toSearchList();
```

### withoutSpellCorrection

```apex
ISearchable withoutSpellCorrection();
```

**Example**

```sql
FIND 'MySearch' IN ALL FIELDS RETURNING Account WITH SPELL_CORRECTION = false
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .withoutSpellCorrection()
    .toSearchList();
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

TBD

**Signature**

```apex
SOSL mockId(String queryIdentifier)
```

**Example**

```apex
TBD
```
### list mock

**Signature**

```apex
SOSL setMock(String mockId, List<SObject> records)
```

**Example**

```apex
TBD
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
============ SOSL Preview ============
SELECT Name, AccountNumber, BillingCity, BillingCountry, BillingCountryCode
FROM Account
WHERE ((Id = :v1 OR Name LIKE :v2))
=======================================
```


## RESULT

### toSearchList

```apex
List<List<SObject>> toSearchList();
```

**Example**

```apex
List<List<SObject>> searchList = SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .toSearchList();
```

### toSearchResult

**Signature**

```apex
Search.SearchResults toSearchResult();
```

**Example**

```apex
Search.SearchResults searchResults = SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .toSearchResult();
```
