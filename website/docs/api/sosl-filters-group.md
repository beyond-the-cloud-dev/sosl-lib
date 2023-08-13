---
sidebar_position: 4
---

# FilterGroup

Create group of conditions.

## Methods

The following are methods for `FilterGroup`.

[**ADD CONDITION**](#add-condition)

- [`add(FilterGroup filterGroup)`](#add)
- [`add(Filter filter)`](#add)
- [`add(String dynamicCondition)`](#add)

[**ORDER**](#order)

- [`anyConditionMatching()`](#anyconditionmatching)
- [`conditionLogic(String order)`](#conditionlogic)

## ADD CONDITION
### add

Allows to add multiple conditions.
Add a [`SOSL.Filter`](sosl-filter.md) or [`SOSL.FilterGroup`](sosl-filters-group.md) or `String`.

**Signature**

```apex
FilterGroup add(FilterGroup filterGroup)
FilterGroup add(Filter filter)
FilterGroup add(String dynamicCondition)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE
    Industry = 'IT' AND
    Name = 'My Account' AND
    NumberOfEmployees >= 10
```

```apex
// build conditions on fly
SOSL.FilterGroup group = SOSL.FilterGroup
    .add(SOSL.Filter.name().equal('My Account'))
    .add(SOSL.Filter.with(Account.NumberOfEmployees).greaterOrEqual(10));

SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
        .add(group)
    ).toList();
```

```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
        .add(SOSL.Filter.name().equal('My Account'))
        .add(SOSL.Filter.with(Account.NumberOfEmployees).greaterOrEqual(10))
    ).toList();
```

```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
        .add(SOSL.Filter.name().equal('My Account'))
        .add('NumberOfEmployees >= 10')
    ).toList();
```

## ORDER
### conditionLogic

Set conditions order for SOSL query.
When not specify all conditions will be with `AND`.

**Signature**

```apex
FilterGroup conditionLogic(String order)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE (Name = 'My Account' AND NumberOfEmployees >= 10)
OR (Name = 'My Account' AND Industry = 'IT')
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.Name).equal('My Account'))
        .add(SOSL.Filter.with(Account.NumberOfEmployees).greaterOrEqual(10))
        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
        .conditionLogic('(1 AND 2) OR (1 AND 3)')
    ).toList();
```

### anyConditionMatching

When the [conditionLogic](#conditionlogic) is not specified, all conditions are joined using the `AND` operator by default.

To change the default condition logic, you can utilize the `anyConditionMatching` method, which joins conditions using the `OR` operator.

**Signature**

```apex
FilterGroup anyConditionMatching()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = 'My Account' OR NumberOfEmployees >= 10
```

```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.Name).equal('My Account'))
        .add(SOSL.Filter.with(Account.NumberOfEmployees).greaterOrEqual(10))
        .anyConditionMatching()
    ).toList();
```
