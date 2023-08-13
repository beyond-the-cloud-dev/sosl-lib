---
sidebar_position: 3
---

# Filter

Specify and adjust single condition.

## Methods

The following are methods for `Filter`.

[**FIELDS**](#fields)

- [`id()`](#id)
- [`recordType()`](#recordtype)
- [`name()`](#name)
- [`with(SObjectField field)`](#with-sobject-field)
- [`with(String field)`](#with-string-field)
- [`with(String relationshipName, SObjectField field)`](#with-related-field)

[**COMPERATORS**](#comperators)

- [`isNull()`](#isnull)
- [`isNotNull()`](#isnotnull)
- [`isTrue()`](#istrue)
- [`isFalse()`](#isfalse)
- [`equal(Object value)`](#equal)
- [`notEqual(Object value)`](#notequal)
- [`lessThan(Object value)`](#lessthan)
- [`greaterThan(Object value)`](#greaterthan)
- [`lessOrEqual(Object value)`](#lessorequal)
- [`greaterOrEqual(Object value)`](#greaterorequal)
- [`containsSome(List<String> values)`](#containssome)
- [`contains(String value)`](#contains)
- [`notContains(String value)`](#notcontains)
- [`endsWith(String value)`](#endswith)
- [`notEndsWith(String value)`](#notendswith)
- [`startsWith(String value)`](#startswith)
- [`notStartsWith(String value)`](#notstartswith)
- [`contains(String prefix, String value, String suffix)`](#contains)
- [`notContains(String prefix, String value, String suffix)`](#notcontains)
- [`isIn(Iterable<Object> iterable)`](#isin)
- [`isIn(List<Object> inList)`](#isin)
- [`isIn(InnerJoin joinQuery)`](#isin-join-query)
- [`notIn(Iterable<Object> iterable)`](#notin)
- [`notIn(List<Object> inList)`](#notin)
- [`notIn(InnerJoin joinQuery)`](#notin-join-query)
- [`includesAll(Iterable<String> values)`](#includesall)
- [`includesSome(Iterable<String> values)`](#includessome)
- [`excludesAll(Iterable<String> values)`](#excludesall)
- [`excludesSome(Iterable<String> values)`](#excludessome)

[**ADDITIONAL**](#additional)

- [`asDateLiteral()`](#asdateliteral)
- [`ignoreWhen(Boolean logicExpression)`](#ignorewhen)

## FIELDS
### id

- `WHERE Id = :accountId`
- `WHERE Id IN :accountIds`

**Signature**

```apex
Filter id()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Id = :accountId
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.id().equal(accountId))
    .toList();
```

### recordType

- `WHERE RecordType.DeveloperName = 'Partner'`

**Signature**

```apex
Filter recordType()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE RecordType.DeveloperName = 'Partner'
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.recordType().equal('Partner'))
    .toList();
```

### Name

- `WHERE Name = 'My Account'`

**Signature**

```apex
Filter name()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = 'My Account'
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.name().equal('My Account'))
    .toList();
```

### with sobject field

Specify field that should be used in the condition.

**Signature**

```apex
Filter with(SObjectField field)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = 'My Account'
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.name().equal('My Account'))
    .toList();
```

### with string field

Specify fields that should be used in the condition.

**Signature**

```apex
Filter with(String field)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = 'My Account'
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with('Name').equal('My Account'))
    .toList();
```

### with related field

Specify parent field that should be used in the condition.

**Signature**

```apex
Filter with(String relationshipPath, SObjectField field);
```

**Example**

```sql
SELECT Id
FROM Contact
WHERE Account.Name = 'My Account'
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with('Account', Account.Name).equal('My Account'))
    .toList();
```

## COMPERATORS

### isNull

- `WHERE Industry = NULL`

**Signature**

```apex
Filter isNull()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Account.Industry = NULL
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.Industry).isNull())
    .toList();
```

### isNotNull

- `WHERE Industry != NULL`

**Signature**

```apex
Filter isNotNull()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Account.Industry != NULL
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.Industry).isNotNull())
    .toList();
```

### isTrue

- `WHERE IsDeleted = TRUE`

**Signature**

```apex
Filter isTrue()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Account.IsDeleted = TRUE
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.IsDeleted).isTrue())
    .toList();
```

### isFalse

- `WHERE IsDeleted = FALSE`

**Signature**

```apex
Filter isFalse()
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Account.IsDeleted != NULL
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.IsDeleted).isFalse())
    .toList();
```

### equal

- `WHERE Name = 'My Account'`
- `WHERE NumberOfEmployees = 10`
- `WHERE IsDeleted = true`

**Signature**

```apex
Filter equal(Object value)
```

**Example**

```sql
SELECT Id FROM Account WHERE Name = 'My Account'

SELECT Id FROM Account WHERE NumberOfEmployees = 10

SELECT Id FROM Account WHERE IsDeleted = true
```

```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().equal('My Account'))
    .toList();

SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).equal(10))
    .toList();

SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.IsDeleted).equal(true))
    .toList();
```

### notEqual

- `WHERE Name != 'My Account'`
- `WHERE NumberOfEmployees != 10`
- `WHERE IsDeleted != true`

**Signature**

```apex
Filter notEqual(Object value)
```

**Example**

```sql
SELECT Id FROM Account WHERE Name != 'My Account'

SELECT Id FROM Account WHERE NumberOfEmployees != 10

SELECT Id FROM Account WHERE IsDeleted != true
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().notEqual('My Account'))
    .toList();

SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).notEqual(10))
    .toList();

SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.IsDeleted).notEqual(true))
    .toList();
```

### lessThan

- `WHERE NumberOfEmployees < 10`

**Signature**

```apex
Filter lessThan(Object value)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE NumberOfEmployees < 10
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).lessThan(10))
    .toList();
```

### greaterThan

- `WHERE NumberOfEmployees > 10`

**Signature**

```apex
Filter greaterThan(Object value)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE NumberOfEmployees > 10
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).greaterThan(10))
    toList();
```

### lessOrEqual

- `WHERE NumberOfEmployees <= 10`

**Signature**

```apex
Filter lessOrEqual(Object value)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE NumberOfEmployees <= 10
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).lessOrEqual(10))
    .toList();
```

### greaterOrEqual

- `WHERE NumberOfEmployees >= 10`

**Signature**

```apex
Filter greaterOrEqual(Object value)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE NumberOfEmployees >= 10
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.NumberOfEmployees).greaterOrEqual(10))
    .toList();
```

### containsSome

- `WHERE Name LIKE ('My', 'Acc')`

**Signature**

```apex
Filter containsSome(List<String> values)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name LIKE ('My', 'Acc')
```
```apex
List<String> names = new List<String>{ 'Acc', 'My' };

SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().containsSome(names))
    .toList();
```

### contains

- `WHERE Name LIKE '%My%'`

**Signature**

```apex
Filter contains(String value)
Filter contains(String prefix, String value, String suffix);
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = '%My%'
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().contains('My'))
    .toList();

SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().contains('_', 'My', '%'))
    .toList();
```

### notcontains

- `WHERE NOT Name LIKE '%My%'`

**Signature**

```apex
Filter notContains(String value)
Filter notContains(String prefix, String value, String suffix);
```

**Example**

```sql
SELECT Id
FROM Account
WHERE NOT Name LIKE '%My%'
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().notContains('My'))
    .toList();

SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().notContains('_', 'My', '%'))
    .toList();
```

### endsWith

- `WHERE Name LIKE '%My'`

**Signature**

```apex
Filter endsWith(String value)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = '%My'
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().endsWith('My'))
    .toList();
```

### notEndsWith

- `WHERE NOT Name LIKE '%My'`

**Signature**

```apex
Filter notEndsWith(String value)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE NOT Name LIKE '%My'
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().notEndsWith('My'))
    .toList();
```

### startsWith

- `WHERE Name LIKE 'My%'`

**Signature**

```apex
Filter startsWith(String value)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Name = 'My%'
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().startsWith('My'))
    .toList();
```

### notStartsWith

- `WHERE NOT Name LIKE 'My%'`

**Signature**

```apex
Filter notStartsWith(String value)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE NOT Name LIKE 'My%'
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.name().notStartsWith('My'))
    .toList();
```

### isIn

- `WHERE Id IN :accountIds`

**Signature**

```apex
Filter isIn(List<Object> inList)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Id IN :accountIds
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.Id).isIn(accountIds))
    .toList();
```

### notIn

- `WHERE Id NOT IN :accountIds`

**Signature**

```apex
Filter notIn(List<Object> inList)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Id NOT IN :accountIds
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.Id).notIn(accountIds))
    .toList();
```

## join query
### isIn join query

- `WHERE Id IN (SELECT AccountId FROM Contact WHERE Name = 'My Contact')`

**Signature**

```apex
Filter isIn(JoinQuery joinQuery)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Id IN (
    SELECT AccountId
    FROM Contact
    WHERE Name = 'My Contact'
)
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.Id).isIn(
        SOSL.InnerJoin.of(Contact.SObjectType)
            .with(Contact.AccountId)
            .whereAre(SOSL.Filter.with(Contact.Name).equal('My Contact'))
    )).toList();
```

### notIn join query

- `WHERE Id NOT IN (SELECT AccountId FROM Contact WHERE Name = 'My Contact')`

**Signature**

```apex
Filter notIn(JoinQuery joinQuery)
```

**Example**

```sql
SELECT Id
FROM Account
WHERE Id NOT IN (
    SELECT AccountId
    FROM Contact
    WHERE Name = 'My Contact'
)
```
```apex
SOSL.of(Contact.SObjectType)
    .whereAre(SOSL.Filter.with(Account.Id).notIn(
        SOSL.InnerJoin.of(Contact.SObjectType)
            .with(Contact.AccountId)
            .whereAre(SOSL.Filter.with(Contact.Name).equal('My Contact'))
    )).toList();
```

## multi-select picklist

### includesAll

- `WHERE Roles INCLUDES ('Business User;Decision Maker')`

**Signature**

```apex
Filter includesAll(Iterable<String> iterable)
```

**Example**

```sql
SELECT Id
FROM AccountContactRelation
WHERE Roles INCLUDES ('Business User;Decision Maker')
```

```apex
List<String> roles = new List<String>{ 'Business User', 'Decision Maker' };

SOSL builder = SOSL.of(AccountContactRelation.SObjectType)
    .with(AccountContactRelation.Id)
    .whereAre(SOSL.Filter.with(AccountContactRelation.Roles).includesAll(roles));
 ```

### includesSome

- `WHERE Roles INCLUDES ('Business User', 'Decision Maker')`

**Signature**

```apex
Filter includesSome(Iterable<String> iterable)
```

**Example**

```sql
SELECT Id
FROM AccountContactRelation
WHERE Roles INCLUDES ('Business User', 'Decision Maker')
```

```apex
List<String> roles = new List<String>{ 'Business User', 'Decision Maker' };

SOSL builder = SOSL.of(AccountContactRelation.SObjectType)
    .with(AccountContactRelation.Id)
    .whereAre(SOSL.Filter.with(AccountContactRelation.Roles).includesSome(roles));
 ```

### excludesAll

- `WHERE Roles EXCLUDES ('Business User', 'Decision Maker')`

**Signature**

```apex
Filter excludesAll(Iterable<String> iterable)
```

**Example**

```sql
SELECT Id
FROM AccountContactRelation
WHERE Roles EXCLUDES ('Business User', 'Decision Maker')
```

```apex
List<String> roles = new List<String>{ 'Business User', 'Decision Maker' };

SOSL builder = SOSL.of(AccountContactRelation.SObjectType)
    .with(AccountContactRelation.Id)
    .whereAre(SOSL.Filter.with(AccountContactRelation.Roles).excludesAll(roles));
 ```

### excludesSome

- `WHERE Roles EXCLUDES ('Business User;Decision Maker')`

**Signature**

```apex
Filter excludesSome(Iterable<String> iterable)
```

**Example**

```sql
SELECT Id
FROM AccountContactRelation
WHERE Roles EXCLUDES ('Business User;Decision Maker')
```

```apex
List<String> roles = new List<String>{ 'Business User', 'Decision Maker' };

SOSL builder = SOSL.of(AccountContactRelation.SObjectType)
    .with(AccountContactRelation.Id)
    .whereAre(SOSL.Filter.with(AccountContactRelation.Roles).excludesSome(roles));
 ```

## ADDITIONAL

### asDateLiteral

[Date Literals](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_dateformats.htm)

SOSL Lib automatically binds all variables; however, Date Literals cannot be binded.
To skip binding for Date Literals, add `asDateLiteral()` to your `Filter`.

**Signature**

```apex
Filter asDateLiteral();
```

**Example**

```sql
SELECT Id
FROM Account
WHERE CreatedDate > 'LAST_90_DAYS'
```
```apex
String accountName = '';

SOSL.of(Account.SObjectType)
    .whereAre(SOSL.Filter.with(Account.CreatedDate).greaterThan('LAST_90_DAYS').asDateLiteral());
    .toList();
```

### ignoreWhen

Condition will be removed when logic expression will evaluate to true.

Note! It does not work when [SOSL.FilterGroup.conditionLogic()](./sosl-filters-group.md#conditionlogic) was used.

**Signature**

```apex
Filter ignoreWhen(Boolean logicExpression);
```

**Example**

```sql
SELECT Id
FROM Account
WHERE BillingCity = 'Krakow'
```
```apex
String accountName = '';

SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.BillingCity).equal('Krakow'))
        .add(SOSL.Filter.name().contains(accountName).ignoreWhen(String.isEmpty(accountName)))
    )
    .toList();
```
