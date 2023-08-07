/**
 * Copyright (c) 2023 BeyondTheCloud.Dev
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/soql-lib/blob/main/LICENSE)
 *
 * PMD False Positives:
 * - ExcessivePublicCount: It is a library class and exposes all necessary methods to construct a query
 * - ExcessiveClassLength: It is a library and we tried to put everything into ONE class
 * - CyclomaticComplexity: It is a library and we tried to put everything into ONE class
 * - CognitiveComplexity: It is a library and we tried to put everything into ONE class
 * - PropertyNamingConventions: It was intentional to make the lib more fluent and readable
 * - FieldDeclarationsShouldBeAtStart: Developer who uses lib should see what's important at start
 * - ApexDoc: Variable names are self-documented.
 * - ExcessiveParameterList - Make methods similar to native SOQL
**/
@SuppressWarnings('PMD.ExcessivePublicCount, PMD.ExcessiveClassLength, PMD.CyclomaticComplexity, PMD.CognitiveComplexity, PMD.PropertyNamingConventions, PMD.FieldDeclarationsShouldBeAtStart, PMD.ApexDoc, PMD.ExcessiveParameterList')
public virtual inherited sharing class SOSL implements ISearchable {

    public static IReturning Returning(SObjectType ofObject) {
        return new ReturningClause(ofObject);
    }

    public static IFilterGroup FilterGroup {
        get {
            return new FilterGroupClause();
        }
    }

    public static IFilter Filter {
        get {
            return new FilterClause();
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
        // withDataCategory
        ISearchable withDivision(String division);
        ISearchable withSnippet(String snippet);
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
        // IReturning orderBy(SObjectField field);
        // IReturning sortDesc();
        // IReturning nullsLast();
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
        IFilter containsSome(List<String> values);
        IFilter contains(String value);
        IFilter endsWith(String value);
        IFilter startsWith(String value);
        IFilter contains(String prefix, String value, String suffix);
        IFilter isIn(Iterable<Object> iterable);
        IFilter isIn(List<Object> inList);
        IFilter notIn(Iterable<Object> iterable);
        IFilter notIn(List<Object> inList);
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

    // public SOSL withDataCategory() Inner Class here

    public SOSL withDivision(String division) {
        builder.soslWiths.newWith().withDivision(division);
        return this;
    }

    public SOSL withHighlight() {
        builder.soslWiths.newWith().withHighlight();
        return this;
    }

    public SOSL withMetadata(String metadata) {
        builder.soslWiths.newWith().withMetadata(metadata);
        return this;
    }

    public SOSL withNetworkEqual(Id networkId) {
        builder.soslWiths.newWith().withNetworkEqual(networkid);
        return this;
    }

    public SOSL withNetworkIn(Iterable<Id> networkIds) {
        builder.soslWiths.newWith().withNetworkIn(networkIds);
        return this;
    }

    public SOSL withPriceBookId(Id priceBookId) {
        builder.soslWiths.newWith().withPriceBookId(priceBookId);
        return this;
    }

    public SOSL withSnippet(String snippet) {
        builder.soslWiths.newWith().withSnippet(snippet);
        return this;
    }

    public SOSL withSpellCorrection() {
        builder.soslWiths.newWith().withSpellCorrection();
        return this;
    }

    public SOSL withoutSpellCorrection() {
        builder.soslWiths.newWith().withoutSpellCorrection();
        return this;
    }

    public SOSL updateViewStat() {
        return this;
    }

    public SOSL updateTracking() {
        return this;
    }

    public override String toString() {
        return builder.toString();
    }

    public interface QueryClause {
        String toString();
    }

    private class SearchableBuilder implements QueryClause {
        private List<QueryClause> clauses = new QueryClause[4];

        public SearchableBuilder(String searchValue) {
            clauses.set(0, new FindClause(searchValue));
        }

        public SearchClause soslSearchGroup {
            get {
                if (clauses[1] == null) {
                    clauses.set(1, new SearchClause());
                }
                return (SearchClause) clauses[1];
            }
        }

        public ReturningClauses soslReturnings {
            get {
                if (clauses[2] == null) {
                    clauses.set(2, new ReturningClauses());
                }
                return (ReturningClauses) clauses[2];
            }
        }

        public LimitClause soslLimit {
            get {
                if (clauses[3] == null) {
                    clauses.set(3, new LimitClause());
                }
                return (LimitClause) clauses[3];
            }
        }

        public WithClauses soslWiths {
            get {
                if (clauses[4] == null) {
                    clauses.set(4, new WithClauses());
                }
                return (WithClauses) clauses[4];
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

    private class FindClause implements QueryClause {
        private String searchValue;

        public FindClause(String searchValue) {
            this.searchValue = searchValue;
        }

        public override String toString() {
            return 'FIND \'' + searchValue + '\'';
        }
    }

    private class SearchClause implements QueryClause {
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

    private class ReturningClauses implements QueryClause {
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

    private class ReturningClause implements QueryClause, IReturning {
        private Integer amount;

        private ReturningClausesBuilder builder;

        public ReturningClause(SObjectType ofObject) {
            builder = new ReturningClausesBuilder(ofObject);
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

    private class ReturningClausesBuilder implements QueryClause {
        private String ofObject;
        private List<QueryClause> clauses = new QueryClause[6];

        public ReturningClausesBuilder(SObjectType ofObject) {
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

        public LimitClause returningLimit {
            get {
                if (clauses[4] == null) {
                    clauses.set(4, new LimitClause());
                }
                return (LimitClause) clauses[4];
            }
        }

        public ReturningOffset returningOffset {
            get {
                if (clauses[5] == null) {
                    clauses.set(5, new ReturningOffset());
                }
                return (ReturningOffset) clauses[5];
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

    private class LimitClause implements QueryClause {
        private Integer amount;

        public void set(Integer amount) {
           this.amount = amount;
        }

        public override String toString() {
            return 'LIMIT ' + amount;
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

    private class WithClauses implements QueryClause {
        private List<WithClause> withs = new List<WithClause>();

        public WithClause newWith() {
            withs.add(new WithClause());
            return withs.get(withs.size() - 1);
        }

        public void add(WithClause with) {
            withs.add(with);
        }

        public override String toString() {
            return String.join(withs, ' ');
        }
    }

    private class WithClause implements QueryClause {
        private String with;

        public void withDivision(String division) {
            with = 'DIVISION = \'' + division + '\'';
        }

        public void withHighlight() {
            with = 'HIGHLIGHT';
        }

        public void withSnippet(String snippet) {
            with = 'SNIPPET = \'' + snippet + '\'';
        }

        public void withNetworkEqual(Id networkid) {
            with = 'NETWORK = \'' + networkid + '\'';
        }

        public void withNetworkIn(Iterable<Id> networkIds) {
            with = 'NETWORK IN (' + String.join(networkIds, ', ') + ')';
        }

        public void withPriceBookId(Id priceBookId) {
            with = 'PricebookId = \'' + priceBookId + '\'';
        }

        public void withMetadata(String metadata) {
            with = 'METADATA = \'' + metadata + '\'';
        }

        public void withSpellCorrection() {
            with = 'SPELL_CORRECTION';
        }

        public void withoutSpellCorrection() {
            with = 'SPELL_CORRECTION = false';
        }

        public override String toString() {
            return 'WITH ' + with;
        }
    }

    public interface IFilterClause {
        Boolean isEmpty();
    }

    private virtual class FilterGroupClause implements IFilterGroup {
        private List<IFilterClause> queryConditions = new List<IFilterClause>();
        private String order;
        private String connector = 'AND';

        public IFilterGroup add(IFilterGroup filterGroup) {
            return add(new QFilterGroupAdapter(filterGroup));
        }

        public IFilterGroup add(IFilter filter) {
            return add(new QFilterAdapter(filter));
        }

        public IFilterGroup add(String dynamicCondition) {
            return add(new QStringAdapter(dynamicCondition));
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

        private void setDefaultOrderWhenEmpty() {
            if (String.isNotEmpty(order)) {
                return;
            }

            List<String> defaultOrder = new List<String>();

            for (Integer i = 1; i <= queryConditions.size(); i++) {
                defaultOrder.add(String.valueOf(i));
            }

            order = String.join(defaultOrder, ' ' + connector + ' '); // e.g (1 AND 2 AND 3)
        }

        public String buildNested() {
            setDefaultOrderWhenEmpty();

            String conditions = applySpecialCharactersToOrder(); // e.g (*1* AND (*2* OR *3*))

            for (Integer i = 0; i < queryConditions.size(); i++) {
                conditions = conditions.replace(
                    conditionNumberWithSpecialCharacters(i + 1), // e.g *1*
                    queryConditions.get(i).toString()
                );
            }

            return conditions;
        }

        private String applySpecialCharactersToOrder() {
            String orderWithSpecialCharacters = order;

            for (Integer i = 1; i <= queryConditions.size(); i++) {
                orderWithSpecialCharacters = orderWithSpecialCharacters.replace(String.valueOf(i), conditionNumberWithSpecialCharacters(i));
            }

            return orderWithSpecialCharacters; // e.g (*1* AND (*2* OR *3*))
        }

        private String conditionNumberWithSpecialCharacters(Integer conditionNumber) {
            return '*' + conditionNumber + '*';
        }
    }

    private class ReturningMainFilterGroup extends FilterGroupClause implements QueryClause {
        public override String toString() {
            if (!hasValues()) {
                return '';
            }

            return 'WHERE ' + buildNested();
        }
    }

    private class QFilterGroupAdapter implements IFilterClause {
        private IFilterGroup filterGroup;

        public QFilterGroupAdapter(IFilterGroup filterGroup) {
            this.filterGroup = filterGroup;
        }

        public Boolean isEmpty() {
            return !filterGroup.hasValues();
        }

        public override String toString() {
            return filterGroup.toString();
        }
    }

    private class QFilterAdapter implements IFilterClause {
        private IFilter filter;

        public QFilterAdapter(IFilter filter) {
            this.filter = filter;
        }

        public Boolean isEmpty() {
            return !filter.hasValue();
        }

        public override String toString() {
            return filter.toString();
        }
    }

    private class QStringAdapter implements IFilterClause {
        private String conditionString;

        public QStringAdapter(String dynamicCondition) {
            conditionString = dynamicCondition;
        }

        public Boolean isEmpty() {
            return String.isEmpty(conditionString);
        }

        public override String toString() {
            return conditionString;
        }
    }

    private class FilterClause implements IFilter, QueryClause {
        private final List<DisplayType> TYPES_WITHOUT_BINDING = new List<DisplayType>{ DisplayType.DateTime };

        private String field;
        private String comperator;
        private Object value;
        private DisplayType fieldType;
        private Boolean skipBinding = false;

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
            skipBinding = TYPES_WITHOUT_BINDING.contains(field.getDescribe().getType());
            return with(field.getDescribe().getName());
        }

        public IFilter with(String relationshipName, SObjectField field) {
            skipBinding = TYPES_WITHOUT_BINDING.contains(field.getDescribe().getType());
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
            return  set('=', '\'' + value + '\'');
        }

        public IFilter notEqual(Object value) {
            return set('!=', value);
        }

        public IFilter notEqual(String value) {
            return set('!=', '\'' + value + '\'');
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

        public IFilter containsSome(List<String> values) {
            return set('LIKE', values);
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
            return set('LIKE', prefix + formattedString(value) + suffix);
        }

        private String formattedString(String value) {
            return value == null ? value : String.escapeSingleQuotes(value.trim());
        }

        public IFilter isIn(Iterable<Object> iterable) {
            return set('IN', iterable);
        }

        public IFilter notIn(Iterable<Object> iterable) {
            return set('NOT IN', iterable);
        }

        public IFilter includesAll(Iterable<String> iterable) {
            // Bind expressions can't be used with other clauses, such as INCLUDES.
            skipBinding = true;
            return set('INCLUDES', '(\'' + String.join(iterable, ';') + '\')');
        }

        public IFilter includesSome(Iterable<String> iterable) {
            // Bind expressions can't be used with other clauses, such as INCLUDES.
            skipBinding = true;
            return set('INCLUDES', '(\'' + String.join(iterable, '\', \'') + '\')');
        }

        public IFilter excludesAll(Iterable<String> iterable) {
            // Bind expressions can't be used with other clauses, such as EXCLUDES.
            skipBinding = true;
            return set('EXCLUDES', '(\'' + String.join(iterable, '\', \'') + '\')');
        }

        public IFilter excludesSome(Iterable<String> iterable) {
            // Bind expressions can't be used with other clauses, such as EXCLUDES.
            skipBinding = true;
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

        public void mockId(String id) {
            mockId = id;
        }

        public List<List<SObject>> execute(String query) {
            // if (mock.hasMock(mockId)) {
            //     return mock.getSObjectsMock(mockId);
            // }

            return sharingExecutor.search(query, accessMode);
        }

    }

    private interface DatabaseSearch {
        List<List<SObject>> search(String query, AccessLevel accessLevel);
    }

    private inherited sharing class InheritedSharing implements DatabaseSearch {
        public List<List<SObject>> search(String query, AccessLevel accessLevel) {
            return Search.query(query, accessLevel);
        }
    }

    private without sharing class WithoutSharing implements DatabaseSearch {
        public List<List<SObject>> search(String query, AccessLevel accessLevel) {
            return Search.query(query, accessLevel);
        }
    }

    private with sharing class WithSharing implements DatabaseSearch {
        public List<List<SObject>> search(String query, AccessLevel accessLevel) {
            return Search.query(query, accessLevel);
        }
    }
}
