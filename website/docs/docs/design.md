---
slug: '/design'
sidebar_position: 40
---

# Design

## Single class

SOSL Lib is a single-class solution.

You don't need to think about dependencies; everything you need is stored in [SOSL.cls](https://github.com/beyond-the-cloud-dev/sosl-lib/blob/main/force-app/main/default/classes/SOSL.cls). The `SOSL.cls` only takes around 1500 lines of code.

Different clauses are encapsulated in small, inner classes.
All crucial information is kept at the top of the class, so developers can use it even without reading the documentation.


```apex
public static SubQuery SubQuery {
    get {
        return new QSubQuery();
    }
}

public static FilterGroup FilterGroup { // A group to nest more filters
    get {
        return new QFilterGroup();
    }
}

public static Filter Filter {
    get {
        return new QFilter();
    }
}

public static InnerJoin InnerJoin {
    get {
        return new QJoinQuery();
    }
}

public interface Selector {
    Queryable query();
}

public interface Queryable {
    Queryable of(SObjectType ofObject);
    Queryable of(String ofObject); // Dynamic SOSL

    Queryable with(SObjectField field);
    Queryable with(SObjectField field1, SObjectField field2);
    Queryable with(SObjectField field1, SObjectField field2, SObjectField field3);
    Queryable with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4);
    Queryable with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5);
    Queryable with(List<SObjectField> fields); // For more than 5 fields
    Queryable with(String fields); // Dynamic SOSL
    Queryable with(SObjectField field, String alias); // Only aggregate expressions use field aliasing
    Queryable with(String relationshipName, SObjectField field);
    Queryable with(String relationshipName, SObjectField field1, SObjectField field2);
    Queryable with(String relationshipName, SObjectField field1, SObjectField field2, SObjectField field3);
    Queryable with(String relationshipName, SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4);
    Queryable with(String relationshipName, SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5);
    Queryable with(String relationshipName, List<SObjectField> fields); // For more than 5 fields
    Queryable with(SubQuery subQuery); // SOSL.SubQuery

    Queryable count();
    Queryable count(SObjectField field);
    Queryable count(SObjectField field, String alias);

    Queryable delegatedScope();
    Queryable mineScope();
    Queryable mineAndMyGroupsScope();
    Queryable myTerritoryScope();
    Queryable myTeamTerritoryScope();
    Queryable teamScope();

    Queryable whereAre(FilterGroup filterGroup); // SOSL.FilterGroup
    Queryable whereAre(Filter filter); // SOSL.Filter
    Queryable whereAre(String conditions); // Conditions to evaluate

    Queryable groupBy(SObjectField field);
    Queryable groupByRollup(SObjectField field);

    Queryable orderBy(String field); // ASC, NULLS FIRST by default
    Queryable orderBy(String field, String direction); // dynamic order by, NULLS FIRST by default
    Queryable orderBy(SObjectField field); // ASC, NULLS FIRST by default
    Queryable orderBy(String relationshipName, SObjectField field); // ASC, NULLS FIRST by default
    Queryable sortDesc();
    Queryable nullsLast();

    Queryable setLimit(Integer amount);

    Queryable offset(Integer startingRow);

    Queryable forReference();
    Queryable forView();
    Queryable forUpdate();
    Queryable allRows();

    Queryable systemMode(); // USER_MODE by default

    Queryable withSharing(); // Works only with .systemMode()
    Queryable withoutSharing(); // Works only with .systemMode()

    Queryable mockId(String id);

    Queryable preview();

    Queryable stripInaccessible();
    Queryable stripInaccessible(AccessType accessType);

    Queryable byId(SObject record);
    Queryable byId(Id recordId);
    Queryable byIds(Iterable<Id> recordIds); // List or Set
    Queryable byIds(List<SObject> records);

    String toString();
    Object toValueOf(SObjectField fieldToExtract);
    Set<String> toValuesOf(SObjectField fieldToExtract);
    Integer toInteger(); // For COUNT query
    SObject toObject();
    List<SObject> toList();
    List<AggregateResult> toAggregated();
    Map<Id, SObject> toMap();
    Database.QueryLocator toQueryLocator();
}

public interface SubQuery { // SOSL.SubQuery
    SubQuery of(String ofObject);

    SubQuery with(SObjectField field);
    SubQuery with(SObjectField field1, SObjectField field2);
    SubQuery with(SObjectField field1, SObjectField field2, SObjectField field3);
    SubQuery with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4);
    SubQuery with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5);
    SubQuery with(List<SObjectField> fields); // For more than 5 fields
    SubQuery with(String relationshipName, List<SObjectField> fields);
    SubQuery with(SubQuery subQuery); // SOSL.SubQuery

    SubQuery whereAre(FilterGroup filterGroup); // SOSL.FilterGroup
    SubQuery whereAre(Filter filter); // SOSL.Filter

    SubQuery orderBy(SObjectField field);
    SubQuery orderBy(String relationshipName, SObjectField field);
    SubQuery sortDesc();
    SubQuery nullsLast();

    SubQuery setLimit(Integer amount);

    SubQuery offset(Integer startingRow);

    SubQuery forReference();
    SubQuery forView();
}

public interface FilterGroup { // SOSL.FilterGroup
    FilterGroup add(FilterGroup filterGroup); // SOSL.FilterGroup
    FilterGroup add(Filter filter); // SOSL.Filter
    FilterGroup add(String dynamicCondition); // Pass condition as String

    FilterGroup anyConditionMatching(); // All group filters will be join by OR
    FilterGroup conditionLogic(String order);

    Boolean hasValues();
}

public interface Filter { // SOSL.Filter
    Filter id();
    Filter recordType();
    Filter name();
    Filter with(SObjectField field);
    Filter with(String field);
    Filter with(String relationshipName, SObjectField field);

    Filter isNull(); // = NULL
    Filter isNotNull(); // != NULL
    Filter isTrue(); // = TRUE
    Filter isFalse(); // = FALSE
    Filter equal(Object value); // = :value
    Filter notEqual(Object value); // != :value
    Filter lessThan(Object value); // < :value
    Filter greaterThan(Object value); // > :value
    Filter lessOrEqual(Object value); // <= :value
    Filter greaterOrEqual(Object value); // >= :value
    Filter containsSome(List<String> values); // LIKE :values
    Filter contains(String value); // LIKE :'%' + value + '%'
    Filter endsWith(String value); // LIKE :'%' + value
    Filter startsWith(String value); // LIKE :value + '%'
    Filter contains(String prefix, String value, String suffix); // custom LIKE
    Filter isIn(Iterable<Object> iterable); // IN :inList or inSet
    Filter isIn(List<Object> inList); // IN :inList
    Filter isIn(InnerJoin joinQuery); // SOSL.InnerJoin
    Filter notIn(Iterable<Object> iterable); // NOT IN :inList or inSet
    Filter notIn(List<Object> inList); // NOT IN :inList
    Filter notIn(InnerJoin joinQuery); // SOSL.InnerJoin
    Filter includesAll(Iterable<String> values); // join with ;
    Filter includesSome(Iterable<String> values); // join with ,
    Filter excludesAll(Iterable<String> values); // join with ,
    Filter excludesSome(Iterable<String> values);  // join with ;

    Filter ignoreWhen(Boolean logicExpression);

    Boolean hasValue();
}

public interface InnerJoin { // SOSL.InnerJoin
    InnerJoin of(SObjectType ofObject);

    InnerJoin with(SObjectField field);

    InnerJoin whereAre(FilterGroup filterGroup); // SOSL.FilterGroup
    InnerJoin whereAre(Filter filter); // SOSL.Filter
}

@TestVisible
private static void setMock(String mockId, SObject record) {
    setMock(mockId, new List<SObject>{ record });
}

@TestVisible
private static void setMock(String mockId, List<SObject> records) {
    mock.setMock(mockId, records);
}

@TestVisible
private static void setCountMock(String mockId, Integer amount) {
    mock.setCountMock(mockId, amount);
}
```

## Functional Programming

SOSL Lib uses the concept called [Apex Functional Programming](https://www.apexfp.org/).

You can see an example of it with `SOSL.SubQuery`, `SOSL.FilterGroup`, `SOSL.Filter` and `SOSL.InnerJoin`.
Those classes encapsulate the logic, and only necessary methods are exposed via interfaces.

```apex
Queryable whereAre(FilterGroup filterGroup); // SOSL.FilterGroup
Queryable whereAre(Filter filter); // SOSL.Filter
```

```apex
SOSL.of(Account.SObjectType)
     .with(Account.Id, Account.Name);
     .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.id().equal(accountId))
        .add(SOSL.Filter.with(Account.Name).contains(accountName))
        .anyConditionMatching() // OR
      )
     .toList();
```

## Return Concrete SOSL instance

```apex
public inherited sharing class SOQL_Account extends SOSL implements SOSL.Selector {
    public static SOQL_Account query() {
        return new SOQL_Account();
    }

    private SOQL_Account() {
        super(Account.SObjectType);
        // default settings
        with(Account.Name, Account.AccountNumber)
            .systemMode();
    }

    public SOQL_Account byRecordType(String rt) {
        with(Account.BillingCity, Account.BillingCountry)
            .whereAre(Filter.recordType().equal(rt));
        return this;
    }

    public SOQL_Account byIndustry(String industry) {
        with(Account.Industry)
            .whereAre(Filter.with(Account.Industry).equal(industry));
        return this;
    }
}
```

As you can see, the method `byRecordType(String rt)` returns an instance of `SOQL_Account` instead of `List<SObject>` or `Object`. Why is that? You can adjust the query to your needs and add more SOSL clauses without duplicating the code.

```apex
SOQL_Account.query()
    .byRecordType(recordType)
    .with(Account.ParentId)
    .toList();

SOQL_Account.query()
    .byRecordType(recordType)
    .byIndustry('IT')
    .orderBy(Account.Name)
    .toList();
```
