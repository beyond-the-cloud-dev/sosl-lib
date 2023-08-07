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
public virtual inherited sharing class SOSL implements Searchable {

    public static Returning Returning(SObjectType ofObject) {
        return new QReturning(ofObject);
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

    public interface Searchable {
        // FIND
        Searchable find(String searchText);
        // IN SearchGroup
        Searchable inAllFields();
        Searchable inNameFields();
        Searchable inEmailFields();
        Searchable inPhoneFields();
        Searchable inSidebarFields();
        // RETURNING
        Searchable returning(Returning returning);
        // WITH
        // withDataCategory
        Searchable withDivision(String division);
        Searchable withSnippet(String snippet);
        Searchable withNetworkEqual(Id networkId);
        Searchable withNetworkIn(Iterable<Id> networkIds);
        Searchable withPriceBookId(Id priceBookId);
        Searchable withMetadata(String metadata);
        Searchable withSpellCorrection();
        Searchable withoutSpellCorrection();
        // LIMIT
        Searchable setLimit(Integer amount);
        // UPDATE
        Searchable updateViewStat();
        Searchable updateTracking();
    }

    public interface Returning {
        // FIELDS
        Returning with(SObjectField field1, SObjectField field2);
        Returning with(SObjectField field1, SObjectField field2, SObjectField field3);
        Returning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4);
        Returning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5);
        Returning with(List<SObjectField> fields); // For more than 5 fields
        // WHERE
        Returning whereAre(FilterGroup filterGroup);
        Returning whereAre(Filter filter);
        // USING LISTVIEW
        Returning usingListView(String listView);
        // ORDER BY
        // Returning orderBy(SObjectField field);
        // Returning sortDesc();
        // Returning nullsLast();
        // LIMIT
        Returning setLimit(Integer amount);
        // OFFSET
        Returning offset(Integer amount);
    }

    public interface FilterGroup { // SOSL.FilterGroup
        // ADD
        FilterGroup add(FilterGroup filterGroup); // SOSL.FilterGroup
        FilterGroup add(Filter filter); // SOSL.Filter
        FilterGroup add(String dynamicCondition); // Pass condition as String
        // CONDITION ORDER
        FilterGroup anyConditionMatching(); // All group filters will be join by OR
        FilterGroup conditionLogic(String order);
        // ADDITIONAL
        Boolean hasValues();
    }

    public interface Filter { // SOSL.Filter
        // FIELDS
        Filter id();
        Filter recordType();
        Filter name();
        Filter with(SObjectField field);
        Filter with(String field);
        Filter with(String relationshipName, SObjectField field);
        // COMPERATORS
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
        Filter notIn(Iterable<Object> iterable); // NOT IN :inList or inSet
        Filter notIn(List<Object> inList); // NOT IN :inList
        Filter includesAll(Iterable<String> values); // join with ;
        Filter includesSome(Iterable<String> values); // join with ,
        Filter excludesAll(Iterable<String> values); // join with ,
        Filter excludesSome(Iterable<String> values);  // join with ;
        // ADDITIONAL
        Filter ignoreWhen(Boolean logicExpression); // Condition will be removed when logicExpression evaluates to true
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
        builder.searchGroup.inAllFields();
        return this;
    }

    public SOSL inNameFields() {
        builder.searchGroup.inNameFields();
        return this;
    }

    public SOSL inEmailFields() {
        builder.searchGroup.inEmailFields();
        return this;
    }

    public SOSL inPhoneFields() {
        builder.searchGroup.inPhoneFields();
        return this;
    }

    public SOSL inSidebarFields() {
        builder.searchGroup.inSidebarFields();
        return this;
    }

    public SOSL returning(Returning returning) {
        builder.returnings.add(returning);
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
            clauses.set(0, new QFind(searchValue));
        }

        public QFind find {
            get {
                return (QFind) clauses[0];
            }
        }

        public QSearchGroup searchGroup {
            get {
                if (clauses[1] == null) {
                    clauses.set(1, new QSearchGroup());
                }
                return (QSearchGroup) clauses[1];
            }
        }

        public QReturnings returnings {
            get {
                if (clauses[2] == null) {
                    clauses.set(2, new QReturnings());
                }
                return (QReturnings) clauses[2];
            }
        }

        public SoslLimit soslLimit {
            get {
                if (clauses[3] == null) {
                    clauses.set(3, new SoslLimit());
                }
                return (SoslLimit) clauses[3];
            }
        }

        public SoslWiths soslWiths {
            get {
                if (clauses[4] == null) {
                    clauses.set(4, new SoslWiths());
                }
                return (SoslWiths) clauses[4];
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

    private class QFind implements QueryClause {
        private String searchValue;

        public QFind(String searchValue) {
            this.searchValue = searchValue;
        }

        public override String toString() {
            return 'FIND \'' + searchValue + '\'';
        }
    }

    private class QSearchGroup implements QueryClause {
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

    private class QReturnings implements QueryClause {
        private List<Returning> returnings = new List<Returning>();

        public void add(Returning returning) {
            returnings.add(returning);
        }

        public override String toString() {
            List<String> returningString = new List<String>();

            for (Returning returning : returnings) {
                returningString.add(returning.toString());
            }

            return 'RETURNING ' + String.join(returningString, ', ');
        }
    }

    private class QReturning implements QueryClause, Returning {
        private Integer amount;

        private ReturningBuilder builder;

        public QReturning(SObjectType ofObject) {
            builder = new ReturningBuilder(ofObject);
        }

        public QReturning with(SObjectField field) {
            builder.fields.with(field);
            return this;
        }

        public QReturning with(SObjectField field1, SObjectField field2) {
            return with(field1).with(field2);
        }

        public QReturning with(SObjectField field1, SObjectField field2, SObjectField field3) {
            return with(field1, field2).with(field3);
        }

        public QReturning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4) {
            return with(field1, field2, field3).with(field4);
        }

        public QReturning with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5) {
            return with(field1, field2, field3, field4).with(field5);
        }

        public QReturning with(List<SObjectField> fields) {
            builder.fields.with(fields);
            return this;
        }

        public QReturning whereAre(FilterGroup filterGroup) {
            builder.conditions.add(filterGroup);
            return this;
        }

        public QReturning whereAre(Filter filter) {
            builder.conditions.add(filter);
            return this;
        }

        public QReturning usingListView(String listView) {
            builder.listView.set(listView);
            return this;
        }

        public QReturning setLimit(Integer amount) {
            builder.returningLimit.set(amount);
            return this;
        }

        public QReturning offset(Integer startingRow) {
            builder.returningOffset.offset(startingRow);
            return this;
        }

        public override String toString() {
            return builder.toString();
        }
    }

    private class ReturningBuilder implements QueryClause {
        private List<QueryClause> clauses = new QueryClause[5];

        public ReturningBuilder(SObjectType ofObject) {
            clauses.set(0, new ROfObject(ofObject));
        }

        public RFields fields {
            get {
                if (clauses[1] == null) {
                    clauses.set(1, new RFields());
                }
                return (RFields) clauses[1];
            }
        }

        public QMainFilterGroup conditions {
            get {
                if (clauses[2] == null) {
                    clauses.set(2, new QMainFilterGroup());
                }
                return (QMainFilterGroup) clauses[2];
            }
        }

        public RListView listView {
            get {
                if (clauses[3] == null) {
                    clauses.set(3, new RListView());
                }
                return (RListView) clauses[3];
            }
        }

        public SoslLimit returningLimit {
            get {
                if (clauses[2] == null) {
                    clauses.set(2, new SoslLimit());
                }
                return (SoslLimit) clauses[2];
            }
        }

        public ROffset returningOffset {
            get {
                if (clauses[3] == null) {
                    clauses.set(3, new ROffset());
                }
                return (ROffset) clauses[3];
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

    private class ROfObject implements QueryClause {
        private String ofObject;

        public ROfObject(SObjectType ofObject) {
            this.ofObject = ofObject.getDescribe().getName();
        }

        public override String toString() {
            return ofObject;
        }
    }

    private class RFields implements QueryClause {
        private Set<String> fields = new Set<String>();

        public RFields with(SObjectField field) {
            fields.add(field.getDescribe().getName());
            return this;
        }

        public RFields with(List<SObjectField> fields) {
            for (SObjectField field : fields) {
                with(field);
            }
            return this;
        }

        public override String toString() {
            return '(' + String.join(fields, ', ') + ')';
        }
    }

    private class RListView implements QueryClause {
        private String listViewName;

        public void set(String listViewName) {
            this.listViewName = listViewName;
        }

        public override String toString() {
            return 'USING LISTVIEW = ' + listViewName;
        }
    }

    private class SoslLimit implements QueryClause {
        private Integer amount;

        public void set(Integer amount) {
           this.amount = amount;
        }

        public override String toString() {
            return 'LIMIT ' + amount;
        }
    }

    private class ROffset implements QueryClause {
        private Integer offset;

        public void offset(Integer offset) {
           this.offset = offset;
        }

        public override String toString() {
            return 'OFFSET ' + offset;
        }
    }

    private class SoslWiths implements QueryClause {
        private List<SoslWith> withs = new List<SoslWith>();

        public SoslWith newWith() {
            withs.add(new SoslWith());
            return withs.get(withs.size() - 1);
        }

        public void add(SoslWith with) {
            withs.add(with);
        }

        public override String toString() {
            return String.join(withs, ' ');
        }
    }

    private class SoslWith implements QueryClause {
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

    public interface FilterClause {
        Boolean isEmpty();
    }

    private virtual class QFilterGroup implements FilterGroup {
        private List<FilterClause> queryConditions = new List<FilterClause>();
        private String order;
        private String connector = 'AND';

        public FilterGroup add(FilterGroup filterGroup) {
            return add(new QFilterGroupAdapter(filterGroup));
        }

        public FilterGroup add(Filter filter) {
            return add(new QFilterAdapter(filter));
        }

        public FilterGroup add(String dynamicCondition) {
            return add(new QStringAdapter(dynamicCondition));
        }

        public FilterGroup add(FilterClause condition) {
            if (condition.isEmpty()) {
                return this;
            }
            queryConditions.add(condition);
            return this;
        }

        public FilterGroup anyConditionMatching() {
            connector = 'OR';
            return this;
        }

        public FilterGroup conditionLogic(String order) {
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

    private class QMainFilterGroup extends QFilterGroup implements QueryClause {
        public override String toString() {
            if (!hasValues()) {
                return '';
            }

            return 'WHERE ' + buildNested();
        }
    }

    private class QFilterGroupAdapter implements FilterClause {
        private FilterGroup filterGroup;

        public QFilterGroupAdapter(FilterGroup filterGroup) {
            this.filterGroup = filterGroup;
        }

        public Boolean isEmpty() {
            return !filterGroup.hasValues();
        }

        public override String toString() {
            return filterGroup.toString();
        }
    }

    private class QFilterAdapter implements FilterClause {
        private Filter filter;

        public QFilterAdapter(Filter filter) {
            this.filter = filter;
        }

        public Boolean isEmpty() {
            return !filter.hasValue();
        }

        public override String toString() {
            return filter.toString();
        }
    }

    private class QStringAdapter implements FilterClause {
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

    private class QFilter implements Filter {
        private final List<DisplayType> TYPES_WITHOUT_BINDING = new List<DisplayType>{ DisplayType.DateTime };

        private String field;
        private String comperator;
        private Object value;
        private DisplayType fieldType;
        private Boolean skipBinding = false;

        public Filter id() {
            return with('Id');
        }

        public Filter recordType() {
            return with('RecordType.DeveloperName');
        }

        public Filter name() {
            return with('Name');
        }

        public Filter with(SObjectField field) {
            skipBinding = TYPES_WITHOUT_BINDING.contains(field.getDescribe().getType());
            return with(field.getDescribe().getName());
        }

        public Filter with(String relationshipName, SObjectField field) {
            skipBinding = TYPES_WITHOUT_BINDING.contains(field.getDescribe().getType());
            return with(relationshipName + '.' + field);
        }

        public Filter with(String field) {
            this.field = field;
            return this;
        }

        public Filter isNull() {
            return equal(null);
        }

        public Filter isNotNull() {
            return notEqual(null);
        }

        public Filter isTrue() {
            return equal(true);
        }

        public Filter isFalse() {
            return equal(false);
        }

        public Filter equal(Object value) {
            return set('=', value);
        }

        public Filter notEqual(Object value) {
            return set('!=', value);
        }

        public Filter lessThan(Object value) {
            return set('<', value);
        }

        public Filter greaterThan(Object value) {
            return set('>', value);
        }

        public Filter lessOrEqual(Object value) {
            return set('<=', value);
        }

        public Filter greaterOrEqual(Object value) {
            return set('>=', value);
        }

        public Filter containsSome(List<String> values) {
            return set('LIKE', values);
        }

        public Filter contains(String value) {
            return contains('%', formattedString(value), '%');
        }

        public Filter endsWith(String value) {
            return contains('%', formattedString(value), '');
        }

        public Filter startsWith(String value) {
            return contains('', formattedString(value), '%');
        }

        public Filter contains(String prefix, String value, String suffix) {
            return set('LIKE', prefix + formattedString(value) + suffix);
        }

        private String formattedString(String value) {
            return value == null ? value : String.escapeSingleQuotes(value.trim());
        }

        public Filter isIn(Iterable<Object> iterable) {
            return set('IN', iterable);
        }

        public Filter notIn(Iterable<Object> iterable) {
            return set('NOT IN', iterable);
        }

        public Filter includesAll(Iterable<String> iterable) {
            // Bind expressions can't be used with other clauses, such as INCLUDES.
            skipBinding = true;
            return set('INCLUDES', '(\'' + String.join(iterable, ';') + '\')');
        }

        public Filter includesSome(Iterable<String> iterable) {
            // Bind expressions can't be used with other clauses, such as INCLUDES.
            skipBinding = true;
            return set('INCLUDES', '(\'' + String.join(iterable, '\', \'') + '\')');
        }

        public Filter excludesAll(Iterable<String> iterable) {
            // Bind expressions can't be used with other clauses, such as EXCLUDES.
            skipBinding = true;
            return set('EXCLUDES', '(\'' + String.join(iterable, '\', \'') + '\')');
        }

        public Filter excludesSome(Iterable<String> iterable) {
            // Bind expressions can't be used with other clauses, such as EXCLUDES.
            skipBinding = true;
            return set('EXCLUDES', '(\'' + String.join(iterable, ';') + '\')');
        }

        private Filter set(String comperator, Object value) {
            this.value = value;
            this.comperator = comperator;
            return this;
        }

        public Boolean hasValue() {
            return String.isNotEmpty(field);
        }

        public Filter ignoreWhen(Boolean logicExpression) {
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
