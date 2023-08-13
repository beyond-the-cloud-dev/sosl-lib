---
sidebar_position: 2
---

# Returning

Construct sub-query with provided API.

## Methods

The following are methods for `Returning`.

[**INIT**](#init)

- [`of(String ofObject)`](#of)

[**SELECT**](#select)

- [`with(SObjectField field)`](#with-fields)
- [`with(SObjectField field1, SObjectField field2)`](#with-field1---field5)
- [`with(SObjectField field1, SObjectField field2, SObjectField field3)`](#with-field1---field5)
- [`with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4)`](#with-field1---field5)
- [`with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5)`](#with-field1---field5)
- [`with(List<SObjectField> fields)`](#with-fields)
- [`with(String relationshipName, List<SObjectField> fields)`](#with-related-fields)

[**SUBQUERY**](#sub-query)

- [`with(SubQuery subQuery)`](#with-subquery)

[**WHERE**](#where)

- [`whereAre(FilterGroup filterGroup)`](#whereare)
- [`whereAre(Filter filter)`](#whereare)

[**ORDER BY**](#order-by)

- [`orderBy(SObjectField field)`](#order-by)
- [`orderBy(String relationshipName, SObjectField field)`](#orderby-related)
- [`sortDesc()`](#sortdesc)
- [`nullsLast()`](#nullslast)

[**LIMIT**](#limit)

- [`setLimit(Integer amount)`](#setlimit)

[**OFFSET**](#offset)

- [`offset(Integer startingRow)`](#offset)

[**FOR**](#for)

- [`forReference()`](#forreference)
- [`forView()`](#forview)

## INIT
### of

Conctructs an `SubQuery`.

**Signature**

```apex
SubQuery of(String ofObject)
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts'))
    .toList();
```

## SELECT

### with field1 - field5

**Signature**

```apex
SubQuery with(SObjectField field);
```
```apex
SubQuery with(SObjectField field1, SObjectField field2);
```
```apex
SubQuery with(SObjectField field1, SObjectField field2, SObjectField field3);
```
```apex
SubQuery with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4);
```
```apex
SubQuery with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5);
```

**Example**

```sql
SELECT Id, (
    SELECT Id, Name
    FROM Contacts
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .with(Contact.Id, Contact.Name)
    )
    .toList();
```

### with fields

Use for more than 5 fields.

**Signature**

```apex
SubQuery with(List<SObjectField> fields)
```

**Example**

```sql
SELECT Id, (
    SELECT Id, Name, Phone, RecordTypeId, Title, Salutation
    FROM Contacts
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .with(new List<SObjectField>{
            Contact.Id,
            Contact.Name,
            Contact.Phone,
            Contact.RecordTypeId,
            Contact.Title,
            Contact.Salutation
        })
    )
    .toList();
```

### with related fields

**Signature**

```apex
SubQuery with(String relationshipName, List<SObjectField> fields)
```


**Example**

```sql
SELECT Id, (
    SELECT CreatedBy.Id, CreatedBy.Name
    FROM Contacts
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .with('CreatedBy', new List<SObjectField>{
            User.Id, User.Name
        })
    )
    .toList();
```

## SUB-QUERY
### with subquery

[Query Five Levels of Parent-to-Child Relationships in SOSL Queries](https://help.salesforce.com/s/articleView?id=release-notes.rn_api_soql_5level.htm&release=244&type=5)

> Use SOSL to query several relationship types.

**Signature**

```apex
SubQuery with(SOSL.SubQuery subQuery)
```

**Example**

```sql
SELECT Name, (
    SELECT LastName , (
        SELECT AssetLevel FROM Assets
    ) FROM Contacts
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .with(Contact.LastName)
        .with(SOSL.SubQuery.of('Assets')
            .with(Asset.AssetLevel)
        )
    ).toList();
```

## WHERE
### whereAre

For more details check [`SOSL.FilterGroup`](sosl-filters-group.md) and [`SOSL.Filter`](sosl-filter.md)

**Signature**

```apex
SubQuery whereAre(FilterClause conditions)
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    WHERE Id = :contactId OR Name = '%John%'
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .whereAre(SOSL.FilterGroup
            .add(SOSL.Filter.with(Contact.Id).equal(contactId))
            .add(SOSL.Filter.with(Contact.Name).contains('John'))
            .conditionLogic('1 OR 2')
        )
    )
    .toList();
```

## ORDER BY
### order by

**Signature**

```apex
SubQuery orderBy(SObjectField field)
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    ORDER BY Name
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .orderBy(Contact.Name)
    )
    .toList();
```

### orderBy related

Order SOSL query by parent field.

**Signature**

```apex
SubQuery orderBy(String relationshipName, SObjectField field)
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    ORDER BY CreatedBy.Name
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .orderBy('CreatedBy', User.Name)
    )
    .toList();
```

### sortDesc

Default order is ascending (`ASC`).

**Signature**

```apex
SubQuery sortDesc()
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    ORDER BY Name DESC
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .orderBy(Contact.Name)
        .sortDesc()
    )
    .toList();
```

### nullsLast

By default, null values are sorted first (`NULLS FIRST`).

**Signature**

```apex
SubQuery nullsLast()
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    ORDER BY Name NULLS LAST
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .orderBy(Contact.Name)
        .nullsLast()
    )
    .toList();
```

## LIMIT
### setLimit


**Signature**

```apex
SubQuery setLimit(Integer amount)
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    LIMIT 100
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .setLimit(100)
    )
    .toList();
```

## OFFSET
### offset

**Signature**

```apex
SubQuery offset(Integer startingRow)
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    OFFSET 10
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .offset(10)
    )
    .toList();
```

## FOR

### forReference

**Signature**

```apex
SubQuery forReference()
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    FOR REFERENCE
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .forReference()
    )
    .toList();
```

### forView

**Signature**

```apex
SubQuery forView()
```

**Example**

```sql
SELECT Id, (
    SELECT Id
    FROM Contacts
    FOR VIEW
) FROM Account
```
```apex
SOSL.of(Account.SObjectType)
    .with(SOSL.SubQuery.of('Contacts')
        .forView()
    )
    .toList();
```
