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
FIND 'MySearch'
IN ALL FIELDS
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
FIND 'MySearch'
IN ALL FIELDS
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
FIND 'MySearch'
IN NAME FIELDS
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
FIND 'MySearch'
IN EMAIL FIELDS
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
FIND 'MySearch'
IN PHONE FIELDS
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
FIND 'MySearch'
IN SIDEBAR FIELDS
```
```apex
SOSL.find('MySearch').inSidebarFields().toSearchList();
```

## RETURNING

For more details check [RETURNING API](./sosl-returning.md).

**Signature**

```apex
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH DIVISION = 'Global'
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH HIGHTLIGHT
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH SNIPPET (target_length=120)
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH NETWORK = 'networkdId'
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH NETWORK IN ('networkdId')
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH PricebookId = 'pricebookId'
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH METADATA = 'LABELS'
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH SPELL_CORRECTION
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
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
WITH SPELL_CORRECTION = false
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

## LIMIT
### setLimit

**Signature**

```apex
ISearchable setLimit(Integer amount);
```

**Example**

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
LIMIT 100
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .setLimit(100)
    .toSearchList();
```

## FIELD-LEVEL SECURITY

[AccessLevel Class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_class_System_AccessLevel.htm#apex_class_System_AccessLevel)

By default AccessLevel is set as `USER_MODE`.

More details you can find in [here](../advanced-usage/fls.md)

### systemMode

> Execution mode in which the the object and field-level permissions of the current user are ignored, and the record sharing rules are controlled by the class sharing keywords.

**Signature**

```apex
ISearchable systemMode();
```

**Example**

```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .systemMode()
    .toSearchList();
```

## SHARING MODE

[Using the with sharing, without sharing, and inherited sharing Keywords](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_sharing.htm)

More details you can find in [here](../advanced-usage/sharing.md).

### withSharing

Execute query `with sharing`.

**Note!** System mode needs to be enabled by `.systemMode()`.

**Signature**

```apex
ISearchable withSharing();
```

**Example**

```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .systemMode()
    .withSharing()
    .toSearchList();
```

### withoutSharing

Execute query `without sharing`.

**Note!** System mode needs to be enabled by `.systemMode()`.

**Signature**

```apex
ISearchable withoutSharing()
```

**Example**

```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .systemMode()
    .withoutSharing()
    .toSearchList();
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
ISearchable preview();
```

**Example**

```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
    )
    .toSearchResult();
```

SOSL preview will be available in debug logs:

```
============ SOSL Preview ============
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account
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
