/**
 * Copyright (c) 2023 BeyondTheCloud.Dev
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/sosl-lib/blob/main/LICENSE)
 *
 * PMD False Positives:
 * - ExcessivePublicCount: It is a library class and exposes all necessary methods to construct a query
 * - ExcessiveClassLength: It is a library and we tried to put everything into ONE class
 * - CyclomaticComplexity: It is a library and we tried to put everything into ONE class
 * - CognitiveComplexity: It is a library and we tried to put everything into ONE class
 * - PropertyNamingConventions: It was intentional to make the lib more fluent and readable
 * - FieldDeclarationsShouldBeAtStart: Developer who uses lib should see what's important at start
 * - ApexDoc: Variable names are self-documented.
 * - ExcessiveParameterList - Make methods similar to native SOSL
**/
@SuppressWarnings('PMD.ExcessivePublicCount, PMD.ExcessiveClassLength, PMD.CyclomaticComplexity, PMD.CognitiveComplexity, PMD.PropertyNamingConventions, PMD.FieldDeclarationsShouldBeAtStart, PMD.ApexDoc, PMD.ExcessiveParameterList')
public inherited sharing class SOSL implements ISearchable {

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
        // MOCKING
        ISearchable mockId(String queryIdentifier);
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

    // Config

    private SearchableBuilder builder;
    private Executor executor;
    private static Mock mock = new Mock();

    public static SOSL find(String searchText) {
        return new SOSL(searchText);
    }

    private SOSL(String searchValue) {
       builder = new SearchableBuilder(searchValue);
       executor = new Executor();
    }

    public SOSL inAllFields() {
        builder.soslSearchGroup.inAllFields();
        return this;
    }

    public SOSL inNameFields() {
        builder.soslSearchGroup.inNameFields();
        return this;
    }

    public SOSL inEmailFields() {
        builder.soslSearchGroup.inEmailFields();
        return this;
    }

    public SOSL inPhoneFields() {
        builder.soslSearchGroup.inPhoneFields();
        return this;
    }

    public SOSL inSidebarFields() {
        builder.soslSearchGroup.inSidebarFields();
        return this;
    }

    public SOSL returning(IReturning returning) {
        builder.soslReturnings.add(returning);
        return this;
    }

    public SOSL setLimit(Integer amount) {
        builder.soslLimit.set(amount);
        return this;
    }

    public SOSL withDivision(String division) {
        builder.soslWiths.withDivision(division);
        return this;
    }

    public SOSL withHighlight() {
        builder.soslWiths.withHighlight();
        return this;
    }

    public SOSL withMetadata(String metadata) {
        builder.soslWiths.withMetadata(metadata);
        return this;
    }

    public SOSL withNetworkEqual(Id networkId) {
        builder.soslWiths.withNetworkEqual(networkid);
        return this;
    }

    public SOSL withNetworkIn(Iterable<Id> networkIds) {
        builder.soslWiths.withNetworkIn(networkIds);
        return this;
    }

    public SOSL withPriceBookId(Id priceBookId) {
        builder.soslWiths.withPriceBookId(priceBookId);
        return this;
    }

    public SOSL withSnippet(Integer targetLength) {
        builder.soslWiths.withSnippet(targetLength);
        return this;
    }

    public SOSL withSpellCorrection() {
        builder.soslWiths.withSpellCorrection();
        return this;
    }

    public SOSL withoutSpellCorrection() {
        builder.soslWiths.withoutSpellCorrection();
        return this;
    }

    public SOSL updateViewStat() {
        builder.soslUpdates.updateViewStat();
        return this;
    }

    public SOSL updateTracking() {
        builder.soslUpdates.updateTracking();
        return this;
    }

    public SOSL mockId(String mockId){
        executor.mockId = mockId;
        return this;
    }

    public ISearchable systemMode() {
        executor.systemMode();
        return this;
    }

    public ISearchable withSharing() {
        executor.withSharing();
        return this;
    }

    public ISearchable withoutSharing() {
        executor.withoutSharing();
        return this;
    }

    @TestVisible
    private static void setMock(String mockId, List<List<SObject>> results){
        mock.setMock(mockId, results);
    }


    public override String toString() {
        return builder.toString();
    }

    public SOSL preview() {
        System.debug(LoggingLevel.ERROR, '\n\n============ SOSL Preview ============\n' + toString() + '\n=======================================\n');
        return this;
    }

    public List<List<SObject>> toSearchList() {
        return executor.search(builder.toString());
    }

    public Search.SearchResults toSearchResult() {
        return executor.find(builder.toString());
    }

    public interface QueryClause {
        String toString();
    }

    private class SearchableBuilder implements QueryClause {
        private List<QueryClause> clauses = new QueryClause[6];

        public SearchableBuilder(String searchValue) {
            clauses.set(0, new SoslFindClause(searchValue));
        }

        public SoslSearchClause soslSearchGroup {
            get {
                if (clauses[1] == null) {
                    clauses.set(1, new SoslSearchClause());
                }
                return (SoslSearchClause) clauses[1];
            }
        }

        public SoslReturningClauses soslReturnings {
            get {
                if (clauses[2] == null) {
                    clauses.set(2, new SoslReturningClauses());
                }
                return (SoslReturningClauses) clauses[2];
            }
        }

        public SoslLimitClause soslLimit {
            get {
                if (clauses[3] == null) {
                    clauses.set(3, new SoslLimitClause());
                }
                return (SoslLimitClause) clauses[3];
            }
        }

        public SoslWithClauses soslWiths {
            get {
                if (clauses[4] == null) {
                    clauses.set(4, new SoslWithClauses());
                }
                return (SoslWithClauses) clauses[4];
            }
        }

        public SoslUpdateClauses soslUpdates {
            get {
                if (clauses[5] == null) {
                    clauses.set(5, new SoslUpdateClauses());
                }
                return (SoslUpdateClauses) clauses[5];
            }
        }

        public override String toString() {
            List<String> soqlParts = new List<String>();

            for (QueryClause clause : clauses) {
                if (clause == null) {
                    continue;
                }
                soqlParts.add(clause.toString());
            }

            return String.join(soqlParts, ' ').trim();
        }
    }

    private class SoslFindClause implements QueryClause {
        private String searchValue;

        public SoslFindClause(String searchValue) {
            this.searchValue = searchValue;
        }

        public override String toString() {
            return 'FIND ' + quote(searchValue);
        }
    }

    private class SoslSearchClause implements QueryClause {
        private String searchGroup;

        public void inAllFields(){
            this.searchGroup = 'ALL';
        }

        public void inEmailFields(){
            this.searchGroup = 'EMAIL';
        }

        public void inNameFields(){
            this.searchGroup = 'NAME';
        }

        public void inPhoneFields(){
            this.searchGroup = 'PHONE';
        }

        public void inSidebarFields(){
            this.searchGroup = 'SIDEBAR';
        }

        public override String toString() {
            return 'IN ' + searchGroup + ' FIELDS';
        }
    }

    private class SoslReturningClauses implements QueryClause {
        private List<IReturning> returnings = new List<IReturning>();

        public void add(IReturning returning) {
            returnings.add(returning);
        }

        public override String toString() {
            List<String> returningString = new List<String>();

            for (IReturning returning : returnings) {
                returningString.add(returning.toString());
            }

            return 'RETURNING ' + String.join(returningString, ', ');
        }
    }

    private class SoslReturningClause implements QueryClause, IReturning {
        private Integer amount;

        private SoslReturningClausesBuilder builder;

        public SoslReturningClause(SObjectType ofObject) {
            builder = new SoslReturningClausesBuilder(ofObject);
        }

        public IReturning with(SObjectField field) {
            builder.fields.with(field);
            return this;
        }

        public IReturning with(SObjectField field1, SObjectField field2) {
            return with(field1).with(field2);
        }

        public IReturning with(SObjectField field1, SObjectField field2, SObjectField field3) {
            return with(field1, field2).with(field3);
        }

        public IReturning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4) {
            return with(field1, field2, field3).with(field4);
        }

        public IReturning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5) {
            return with(field1, field2, field3, field4).with(field5);
        }

        public IReturning with(List<SObjectField> fields) {
            builder.fields.with(fields);
            return this;
        }

        public IReturning whereAre(IFilterGroup filterGroup) {
            builder.conditions.add(filterGroup);
            return this;
        }

        public IReturning whereAre(IFilter filter) {
            builder.conditions.add(filter);
            return this;
        }

        public IReturning usingListView(String listView) {
            builder.listView.set(listView);
            return this;
        }

        public IReturning orderBy(String field) {
            builder.orderBys.newOrderBy().with(field);
            return this;
        }

        public IReturning orderBy(String field, String direction) {
            builder.orderBys.newOrderBy().with(field).sortingOrder(direction);
            return this;
        }

        public IReturning orderBy(SObjectField field) {
            builder.orderBys.newOrderBy().with(field);
            return this;
        }

        public IReturning orderBy(String relationshipName, SObjectField field) {
            builder.orderBys.newOrderBy().with(relationshipName, field);
            return this;
        }

        public IReturning sortDesc() {
            builder.latestOrderBy.sortDesc();
            return this;
        }

        public IReturning nullsLast() {
            builder.latestOrderBy.nullsLast();
            return this;
        }

        public IReturning setLimit(Integer amount) {
            builder.returningLimit.set(amount);
            return this;
        }

        public IReturning offset(Integer startingRow) {
            builder.returningOffset.offset(startingRow);
            return this;
        }

        public override String toString() {
            return builder.toString();
        }
    }

    private class SoslReturningClausesBuilder implements QueryClause {
        private String ofObject;
        private List<QueryClause> clauses = new QueryClause[7];

        public SoslReturningClausesBuilder(SObjectType ofObject) {
            this.ofObject = ofObject.getDescribe().getName();
        }

        public ReturningFields fields {
            get {
                if (clauses[1] == null) {
                    clauses.set(1, new ReturningFields());
                }
                return (ReturningFields) clauses[1];
            }
        }

        public ReturningMainFilterGroup conditions {
            get {
                if (clauses[2] == null) {
                    clauses.set(2, new ReturningMainFilterGroup());
                }
                return (ReturningMainFilterGroup) clauses[2];
            }
        }

        public ReturningListView listView {
            get {
                if (clauses[3] == null) {
                    clauses.set(3, new ReturningListView());
                }
                return (ReturningListView) clauses[3];
            }
        }

        public ReturningOrderBy latestOrderBy {
            get {
                return orderBys.recentOrderBy();
            }
        }

        public ReturningOrderBys orderBys {
            get {
                if (clauses[4] == null) {
                    clauses.set(4, new ReturningOrderBys());
                }
                return (ReturningOrderBys) clauses[4];
            }
        }

        public SoslLimitClause returningLimit {
            get {
                if (clauses[5] == null) {
                    clauses.set(5, new SoslLimitClause());
                }
                return (SoslLimitClause) clauses[5];
            }
        }

        public ReturningOffset returningOffset {
            get {
                if (clauses[6] == null) {
                    clauses.set(6, new ReturningOffset());
                }
                return (ReturningOffset) clauses[6];
            }
        }

        public override String toString() {
            List<String> soqlParts = new List<String>();

            for (QueryClause clause : clauses) {
                if (clause == null) {
                    continue;
                }
                soqlParts.add(clause.toString());
            }

            if (soqlParts.isEmpty()) {
                return ofObject;
            }

            return ofObject + '(' + String.join(soqlParts, ' ').trim() + ')';
        }
    }

    private class ReturningFields implements QueryClause {
        private Set<String> fields = new Set<String>();

        public ReturningFields with(SObjectField field) {
            fields.add(field.getDescribe().getName());
            return this;
        }

        public ReturningFields with(List<SObjectField> fields) {
            for (SObjectField field : fields) {
                with(field);
            }
            return this;
        }

        public override String toString() {
            return String.join(fields, ', ');
        }
    }

    private class ReturningListView implements QueryClause {
        private String listViewName;

        public void set(String listViewName) {
            this.listViewName = listViewName;
        }

        public override String toString() {
            return 'USING LISTVIEW = ' + listViewName;
        }
    }

    private class ReturningOrderBys implements QueryClause {
        public List<ReturningOrderBy> orderBys = new List<ReturningOrderBy>();

        public ReturningOrderBy newOrderBy() {
            orderBys.add(new ReturningOrderBy());
            return recentOrderBy();
        }

        public ReturningOrderBy recentOrderBy() {
            return orderBys.get(orderBys.size() - 1);
        }

        public override String toString() {
            List<String> orderFields = new List<String>();

            for (ReturningOrderBy orderBy : orderBys) {
                orderFields.add(orderBy.toString());
            }

            return 'ORDER BY ' + String.join(orderFields, ', ');
        }
    }

    private class ReturningOrderBy implements QueryClause {
        private String orderField;
        private String sortingOrder = 'ASC';
        private String nullsOrder = 'FIRST';

        public ReturningOrderBy with(SObjectField field) {
            return with(field.getDescribe().getName());
        }

        public ReturningOrderBy with(String relationshipName, SObjectField field) {
            return with(relationshipName + '.' + field);
        }

        public ReturningOrderBy with(String field) {
            orderField = field;
            return this;
        }

        public void sortDesc() {
            sortingOrder('DESC');
        }

        public ReturningOrderBy sortingOrder(String direction) {
            sortingOrder = direction;
            return this;
        }

        public void nullsLast() {
            nullsOrder = 'LAST';
        }

        public override String toString() {
            return orderField + ' ' + sortingOrder + ' NULLS ' + nullsOrder;
        }
    }

    private class ReturningOffset implements QueryClause {
        private Integer offset;

        public void offset(Integer offset) {
           this.offset = offset;
        }

        public override String toString() {
            return 'OFFSET ' + offset;
        }
    }

    private class SoslLimitClause implements QueryClause {
        private Integer amount;

        public void set(Integer amount) {
           this.amount = amount;
        }

        public override String toString() {
            return 'LIMIT ' + amount;
        }
    }

    private class SoslWithClauses implements QueryClause {
        private List<String> withs = new List<String>();

        public void withDivision(String division) {
            add('DIVISION = ' + quote(division));
        }

        public void withHighlight() {
            add('HIGHLIGHT');
        }

        public void withSnippet(Integer targetLength) {
            add('SNIPPET (target_length=' + targetLength + ')');
        }

        public void withNetworkEqual(Id networkid) {
            add('NETWORK = ' + quote(networkid));
        }

        public void withNetworkIn(Iterable<Id> networkIds) {
            add('NETWORK IN (\'' +  String.join(networkIds, '\', \'') + '\')');
        }

        public void withPriceBookId(Id priceBookId) {
            add('PricebookId = ' + quote(priceBookId));
        }

        public void withMetadata(String metadata) {
            add('METADATA = ' + quote(metadata));
        }

        public void withSpellCorrection() {
            add('SPELL_CORRECTION');
        }

        public void withoutSpellCorrection() {
            add('SPELL_CORRECTION = false');
        }

        public void add(String withClause) {
            withs.add('WITH ' + withClause);
        }

        public override String toString() {
            return String.join(withs, ' ');
        }
    }

    public class SoslUpdateClauses implements QueryClause {
        private List<String> updateClauses = new List<String>();


        public void updateViewStat() {
            updateClauses.add('VIEWSTAT');
        }

        public void updateTracking() {
            updateClauses.add('TRACKING');
        }

        public override String toString() {
            return 'UPDATE ' + String.join(updateClauses, ' ');
        }
    }

    public interface IFilterClause {
        Boolean isEmpty();
    }

    private virtual class SoslFilterGroupClause implements IFilterGroup {
        private List<IFilterClause> queryConditions = new List<IFilterClause>();
        private String order;
        private String connector = 'AND';

        public IFilterGroup add(IFilterGroup filterGroup) {
            return add(new SoslFilterGroupAdapter(filterGroup));
        }

        public IFilterGroup add(IFilter filter) {
            return add(new SoslFilterAdapter(filter));
        }

        public IFilterGroup add(String dynamicCondition) {
            return add(new SoslStringAdapter(dynamicCondition));
        }

        public IFilterGroup add(IFilterClause condition) {
            if (condition.isEmpty()) {
                return this;
            }
            queryConditions.add(condition);
            return this;
        }

        public IFilterGroup anyConditionMatching() {
            connector = 'OR';
            return this;
        }

        public IFilterGroup conditionLogic(String order) {
            this.order = order;
            return this;
        }

        public Boolean hasValues() {
            return !queryConditions.isEmpty();
        }

        public virtual override String toString() {
            return '(' + buildNested() + ')';
        }

        private void setDefaultOrderWhenNotSpecified() {
            if (String.isNotEmpty(order)) {
                return;
            }

            List<String> defaultOrder = new List<String>();

            for (Integer i = 0; i < queryConditions.size(); i++) {
                defaultOrder.add(String.valueOf(i + 1));
            }

            order = String.join(defaultOrder, ' ' + connector + ' ');
        }

        public String buildNested() {
            setDefaultOrderWhenNotSpecified(); // e.g (0 AND 1 AND 2)
            addSpecialCharactersToOrder(); // e.g ({0} AND ({1} AND {2}))

            return String.format(order, queryConditions);
        }

        private void addSpecialCharactersToOrder() {
            for (Integer i = 0; i < queryConditions.size(); i++) {
                order = order.replace(String.valueOf(i + 1), '{' + i + '}');
            }
        }
    }

    private class ReturningMainFilterGroup extends SoslFilterGroupClause implements QueryClause {
        public override String toString() {
            if (!hasValues()) {
                return '';
            }

            return 'WHERE ' + buildNested();
        }
    }

    private class SoslFilterGroupAdapter implements IFilterClause {
        private IFilterGroup filterGroup;

        public SoslFilterGroupAdapter(IFilterGroup filterGroup) {
            this.filterGroup = filterGroup;
        }

        public Boolean isEmpty() {
            return !filterGroup.hasValues();
        }

        public override String toString() {
            return filterGroup.toString();
        }
    }

    private class SoslFilterAdapter implements IFilterClause {
        private IFilter filter;

        public SoslFilterAdapter(IFilter filter) {
            this.filter = filter;
        }

        public Boolean isEmpty() {
            return !filter.hasValue();
        }

        public override String toString() {
            return filter.toString();
        }
    }

    private class SoslStringAdapter implements IFilterClause {
        private String conditionString;

        public SoslStringAdapter(String dynamicCondition) {
            conditionString = dynamicCondition;
        }

        public Boolean isEmpty() {
            return String.isEmpty(conditionString);
        }

        public override String toString() {
            return conditionString;
        }
    }

    private class SoslFilterClause implements IFilter, QueryClause {
        private String field;
        private String comperator;
        private Object value;

        public IFilter id() {
            return with('Id');
        }

        public IFilter recordType() {
            return with('RecordType.DeveloperName');
        }

        public IFilter name() {
            return with('Name');
        }

        public IFilter with(SObjectField field) {
            return with(field.getDescribe().getName());
        }

        public IFilter with(String relationshipName, SObjectField field) {
            return with(relationshipName + '.' + field);
        }

        public IFilter with(String field) {
            this.field = field;
            return this;
        }

        public IFilter isNull() {
            return set('=', null);
        }

        public IFilter isNotNull() {
            return set('!=', null);
        }

        public IFilter isTrue() {
            return equal(true);
        }

        public IFilter isFalse() {
            return equal(false);
        }

        public IFilter equal(Object value) {
            return set('=', value);
        }

        public IFilter equal(String value) {
            return  set('=', quote(value));
        }

        public IFilter notEqual(Object value) {
            return set('!=', value);
        }

        public IFilter notEqual(String value) {
            return set('!=', quote(value));
        }

        public IFilter lessThan(Object value) {
            return set('<', value);
        }

        public IFilter greaterThan(Object value) {
            return set('>', value);
        }

        public IFilter lessOrEqual(Object value) {
            return set('<=', value);
        }

        public IFilter greaterOrEqual(Object value) {
            return set('>=', value);
        }

        public IFilter containsSome(Iterable<String> values) {
            return set('LIKE', '(\'' + String.join(values, '\'') + '\')');
        }

        public IFilter contains(String value) {
            return contains('%', formattedString(value), '%');
        }

        public IFilter endsWith(String value) {
            return contains('%', formattedString(value), '');
        }

        public IFilter startsWith(String value) {
            return contains('', formattedString(value), '%');
        }

        public IFilter contains(String prefix, String value, String suffix) {
            return set('LIKE', quote(prefix + formattedString(value) + suffix));
        }

        private String formattedString(String value) {
            return value == null ? value : String.escapeSingleQuotes(value.trim());
        }

        public IFilter isIn(Iterable<Object> iterable) {
            return set('IN', iterable);
        }

        public IFilter isIn(List<String> iterable) {
            return set('IN', '(\'' + String.join(iterable, '\'') + '\')');
        }

        public IFilter notIn(Iterable<Object> iterable) {
            return set('NOT IN', iterable);
        }

        public IFilter notIn(List<String> iterable) {
            return set('NOT IN', '(\'' + String.join(iterable, '\'') + '\')');
        }

        public IFilter includesAll(Iterable<String> iterable) {
            return set('INCLUDES', '(\'' + String.join(iterable, ';') + '\')');
        }

        public IFilter includesSome(Iterable<String> iterable) {
            return set('INCLUDES', '(\'' + String.join(iterable, '\', \'') + '\')');
        }

        public IFilter excludesAll(Iterable<String> iterable) {
            return set('EXCLUDES', '(\'' + String.join(iterable, '\', \'') + '\')');
        }

        public IFilter excludesSome(Iterable<String> iterable) {
            return set('EXCLUDES', '(\'' + String.join(iterable, ';') + '\')');
        }

        private IFilter set(String comperator, Object value) {
            this.value = value;
            this.comperator = comperator;
            return this;
        }

        public Boolean hasValue() {
            return String.isNotEmpty(field);
        }

        public IFilter ignoreWhen(Boolean logicExpression) {
            if (logicExpression) {
                // Set field as empty to meet hasValue and ignore condition
                with('');
            }
            return this;
        }

        public override String toString() {
            // Dynamic binding not available for SOSL
             return field + ' ' + comperator + ' ' + value;
        }
    }

    private inherited sharing class Executor {
        private AccessLevel accessMode = AccessLevel.USER_MODE; // The object permissions, field-level security, sharing rules are enforced.
        private DatabaseSearch sharingExecutor = new InheritedSharing();
        private AccessType accessType;
        private String mockId;

        public void withSharing() {
            sharingExecutor = new WithSharing();
        }

        public void withoutSharing() {
            sharingExecutor = new WithoutSharing();
        }

        public void systemMode() { // The object permissions, field-level permissions are ignored, sharing rules are controlled by the sharingMode.
            accessMode = AccessLevel.SYSTEM_MODE;
        }

        public List<List<SObject>> search(String query) {
            if(mock.hasMock(mockId)){
                return mock.getMock(mockId);
            }

            return sharingExecutor.search(query, accessMode);
        }

        public Search.SearchResults find(String query) {
            return sharingExecutor.find(query, accessMode);
        }
    }

    private interface DatabaseSearch {
        List<List<SObject>> search(String query, AccessLevel accessLevel);
        Search.SearchResults find(String query, AccessLevel accessLevel);
    }

    private inherited sharing class InheritedSharing implements DatabaseSearch {
        public List<List<SObject>> search(String query, AccessLevel accessLevel) {
            return Search.query(query, accessLevel);
        }

        public Search.SearchResults find(String query, AccessLevel accessLevel) {
            return Search.find(query, accessLevel);
        }
    }

    private without sharing class WithoutSharing implements DatabaseSearch {
        public List<List<SObject>> search(String query, AccessLevel accessLevel) {
            return Search.query(query, accessLevel);
        }

        public Search.SearchResults find(String query, AccessLevel accessLevel) {
            return Search.find(query, accessLevel);
        }
    }

    private with sharing class WithSharing implements DatabaseSearch {
        public List<List<SObject>> search(String query, AccessLevel accessLevel) {
            return Search.query(query, accessLevel);
        }

        public Search.SearchResults find(String query, AccessLevel accessLevel) {
            return Search.find(query, accessLevel);
        }
    }

    private class Mock {
        private final Map<String, List<List<SObject>>> sObjectsMocks = new Map<String, List<List<SObject>>>();

        public void setMock(String mockId, List<List<SObject>> results){
            sObjectsMocks.put(mockId, results);
        }

        public Boolean hasMock(String mockId){
            return sObjectsMocks.containsKey(mockId);
        }

        public List<List<SObject>> getMock(String mockId){
            return sObjectsMocks.get(mockId);
        }
    }

    private static String quote(String value) {
        return '\'' + value + '\'';
    }
}
