---
sidebar_position: 2
---

# Returning

Construct sub-query with provided API.

## Methods

The following are methods for `Returning`.

[**RETURNING**](#returning)

[**FIELDS**](#fields)

- [`with(SObjectField field)`](#with-fields)
- [`with(SObjectField field1, SObjectField field2)`](#with-field1---field5)
- [`with(SObjectField field1, SObjectField field2, SObjectField field3)`](#with-field1---field5)
- [`with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4)`](#with-field1---field5)
- [`with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5)`](#with-field1---field5)
- [`with(List<SObjectField> fields)`](#with-fields)

[**WHERE**](#where)

- [`whereAre(FilterGroup filterGroup)`](#whereare)
- [`whereAre(Filter filter)`](#whereare)

[**ORDER BY**](#order-by)

- [`orderBy(String field)`](#order-by)
- [`orderBy(String field, String direction)`](#order-by)
- [`orderBy(SObjectField field)`](#order-by)
- [`orderBy(String relationshipName, SObjectField field)`](#orderby-related)
- [`sortDesc()`](#sortdesc)
- [`nullsLast()`](#nullslast)

[**LIMIT**](#limit)

- [`setLimit(Integer amount)`](#setlimit)

[**OFFSET**](#offset)

- [`offset(Integer startingRow)`](#offset)

## RETURNING

TBD

## FIELDS

### with field1 - field5

**Signature**

```apex
IReturning with(SObjectField field);
```
```apex
IReturning with(SObjectField field1, SObjectField field2);
```
```apex
IReturning with(SObjectField field1, SObjectField field2, SObjectField field3);
```
```apex
IReturning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4);
```
```apex
IReturning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5);
```

**Example**

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Account(Id, Name)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Account.SObjectType)
            .with(Account.Id, Account.Name)
    )
    .toSearchList();
```

### with fields

Use for more than 5 fields.

**Signature**

```apex
IReturning with(List<SObjectField> fields);
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
**Example**

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Contact(Id, Name, Phone, RecordTypeId, Title, Salutation)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Contact.SObjectType)
            .with(new List<SObjectField>{
                Contact.Id,
                Contact.Name,
                Contact.Phone,
                Contact.RecordTypeId,
                Contact.Title,
                Contact.Salutation
            })
    )
    .toSearchList();
```

## WHERE
### whereAre

For more details check [`SOSL.FilterGroup`](sosl-filters-group.md) and [`SOSL.Filter`](sosl-filter.md)

**Signature**

```apex
IReturning whereAre(FilterClause conditions);
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

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Contact(
    Id, Name
    WHERE Id = 'contactId' OR Name = 'John'
)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Contact.SObjectType)
            .with(Contact.Id, Contact.Name)
            .whereAre(SOSL.FilterGroup
                .add(SOSL.Filter.with(Contact.Id).equal(contactId))
                .add(SOSL.Filter.with(Contact.Name).contains('John'))
                .conditionLogic('1 OR 2')
            )
    )
    .toSearchList();
```

## ORDER BY
### order by

**Signature**

```apex
IReturning orderBy(SObjectField field);
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

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Contact(
    Id, Name
    ORDER BY Name
)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Contact.SObjectType)
            .with(Contact.Id, Contact.Name)
            .orderBy(Contact.Name)
    )
    .toSearchList();
```
### orderBy related

Order SOSL query by parent field.

**Signature**

```apex
IReturning orderBy(String relationshipName, SObjectField field);
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

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Contact(
    Id, Name
    ORDER BY CreatedBy.Name
)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Contact.SObjectType)
            .with(Contact.Id, Contact.Name)
            .orderBy('CreatedBy', User.Name)
    )
    .toSearchList();
```

### sortDesc

Default order is ascending (`ASC`).

**Signature**

```apex
IReturning sortDesc();
```

**Example**

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Contact(
    Id, Name
    ORDER BY Name DESC
)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Contact.SObjectType)
            .with(Contact.Id, Contact.Name)
            .orderBy(Contact.Name).sortDesc()
    )
    .toSearchList();
```
### nullsLast

By default, null values are sorted first (`NULLS FIRST`).

**Signature**

```apex
IReturning nullsLast();
```

**Example**

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Contact(
    Id, Name
    ORDER BY Name ASC NULLS LAST
)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Contact.SObjectType)
            .with(Contact.Id, Contact.Name)
            .orderBy(Contact.Name).nullsLast()
    )
    .toSearchList();
```

## LIMIT
### setLimit

**Signature**

```apex
IReturning setLimit(Integer amount);
```

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Contact(
    Id, Name
    LIMIT 100
)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Contact.SObjectType)
            .with(Contact.Id, Contact.Name)
            .setLimit(100)
    )
    .toSearchList();
```

## OFFSET

**Signature**

```apex
IReturning offset(Integer startingRow);
```

**Example**

```sql
FIND 'MySearch'
IN ALL FIELDS
RETURNING Contact(
    Id, Name
    OFFSET 10
)
```
```apex
SOSL.find('MySearch')
    .inAllFields()
    .returning(
        SOQL.Returning(Contact.SObjectType)
            .with(Contact.Id, Contact.Name)
            .offset(10)
    )
    .toSearchList();
```
