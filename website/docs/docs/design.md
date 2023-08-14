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
public static IReturning Returning(SObjectType ofObject) {
    return new SoslReturningClause(ofObject);
}

public static IFilterGroup FilterGroup {
    get {
        return new SoslFilterGroupClause();
    }
}

public static IFilter Filter {
    get {
        return new SoslFilterClause();
    }
}

public interface ISearchable {
    // FIND
    ISearchable find(String searchText);
    // IN SearchGroup
    ISearchable inAllFields();
    ISearchable inNameFields();
    ISearchable inEmailFields();
    ISearchable inPhoneFields();
    ISearchable inSidebarFields();
    // RETURNING
    ISearchable returning(IReturning returning);
    // WITH
    ISearchable withDivision(String division);
    ISearchable withHighlight();
    ISearchable withSnippet(Integer targetLength);
    ISearchable withNetworkEqual(Id networkId);
    ISearchable withNetworkIn(Iterable<Id> networkIds);
    ISearchable withPriceBookId(Id priceBookId);
    ISearchable withMetadata(String metadata);
    ISearchable withSpellCorrection();
    ISearchable withoutSpellCorrection();
    // LIMIT
    ISearchable setLimit(Integer amount);
    // UPDATE
    ISearchable updateViewStat();
    ISearchable updateTracking();
    // FIELD-LEVEL SECURITY
    ISearchable systemMode();
    // SHARING MODE
    ISearchable withSharing();
    ISearchable withoutSharing();
    // DEBUGGING
    ISearchable preview();
    // RESULT
    List<List<SObject>> toSearchList();
    Search.SearchResults toSearchResult();
}

public interface IReturning {
    // FIELDS
    IReturning with(SObjectField field);
    IReturning with(SObjectField field1, SObjectField field2);
    IReturning with(SObjectField field1, SObjectField field2, SObjectField field3);
    IReturning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4);
    IReturning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5);
    IReturning with(List<SObjectField> fields);
    // WHERE
    IReturning whereAre(IFilterGroup filterGroup);
    IReturning whereAre(IFilter filter);
    // USING LISTVIEW
    IReturning usingListView(String listView);
    // ORDER BY
    IReturning orderBy(String field);
    IReturning orderBy(String field, String direction);
    IReturning orderBy(SObjectField field);
    IReturning orderBy(String relationshipName, SObjectField field);
    IReturning sortDesc();
    IReturning nullsLast();
    // LIMIT
    IReturning setLimit(Integer amount);
    // OFFSET
    IReturning offset(Integer amount);
}

public interface IFilterGroup {
    // ADD
    IFilterGroup add(IFilterGroup filterGroup);
    IFilterGroup add(IFilter filter);
    IFilterGroup add(String dynamicCondition);
    // CONDITION ORDER
    IFilterGroup anyConditionMatching();
    IFilterGroup conditionLogic(String order);
    // ADDITIONAL
    Boolean hasValues();
}

public interface IFilter {
    // FIELDS
    IFilter id();
    IFilter recordType();
    IFilter name();
    IFilter with(SObjectField field);
    IFilter with(String field);
    IFilter with(String relationshipName, SObjectField field);
    // COMPERATORS
    IFilter isNull();
    IFilter isNotNull();
    IFilter isTrue();
    IFilter isFalse();
    IFilter equal(Object value);
    IFilter equal(String value);
    IFilter notEqual(Object value);
    IFilter notEqual(String value);
    IFilter lessThan(Object value);
    IFilter greaterThan(Object value);
    IFilter lessOrEqual(Object value);
    IFilter greaterOrEqual(Object value);
    IFilter containsSome(Iterable<String> values);
    IFilter contains(String value);
    IFilter endsWith(String value);
    IFilter startsWith(String value);
    IFilter contains(String prefix, String value, String suffix);
    IFilter isIn(Iterable<Object> iterable);
    IFilter isIn(List<Object> inList);
    IFilter isIn(List<String> inList);
    IFilter notIn(Iterable<Object> iterable);
    IFilter notIn(List<Object> inList);
    IFilter notIn(List<String> inList);
    IFilter includesAll(Iterable<String> values);
    IFilter includesSome(Iterable<String> values);
    IFilter excludesAll(Iterable<String> values);
    IFilter excludesSome(Iterable<String> values);
    // ADDITIONAL
    IFilter ignoreWhen(Boolean logicExpression);
    Boolean hasValue();
}
```

## Functional Programming

SOSL Lib uses the concept called [Apex Functional Programming](https://www.apexfp.org/).

You can see an example of it with `SOSL.Returning`, `SOSL.FilterGroup` and`SOSL.Filter`.

Those classes encapsulate the logic, and only necessary methods are exposed via interfaces.

```apex
IReturning whereAre(FilterGroup filterGroup); // SOSL.FilterGroup
IReturning whereAre(Filter filter); // SOSL.Filter
```

```apex
SOSL.find(SEARCH_TEXT)
    .inAllFields()
    .returning(
        SOSL.Returning(Account.SObjectType)
            .with(Account.Id, Account.Name)
            .whereAre(SOSL.FilterGroup
                .add(SOSL.Filter.with(Account.Name).equal(accountName).ignoreWhen(String.isEmpty(accountName)))
                .add(SOSL.Filter.with(Account.Industry).equal('IT'))
            )
    )
    .toSearchList();
```
