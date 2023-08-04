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
public virtual inherited sharing class SOSL {

    public interface FilterGroup { // SOQL.FilterGroup
        FilterGroup add(FilterGroup filterGroup); // SOQL.FilterGroup
        FilterGroup add(Filter filter); // SOQL.Filter
        FilterGroup add(String dynamicCondition); // Pass condition as String

        FilterGroup anyConditionMatching(); // All group filters will be join by OR
        FilterGroup conditionLogic(String order);

        Boolean hasValues();
    }

    public interface Filter { // SOQL.Filter
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
        Filter notIn(Iterable<Object> iterable); // NOT IN :inList or inSet
        Filter notIn(List<Object> inList); // NOT IN :inList
        Filter includesAll(Iterable<String> values); // join with ;
        Filter includesSome(Iterable<String> values); // join with ,
        Filter excludesAll(Iterable<String> values); // join with ,
        Filter excludesSome(Iterable<String> values);  // join with ;

        Filter ignoreWhen(Boolean logicExpression); // Condition will be removed when logicExpression evaluates to true

        Boolean hasValue();
    }

    public SOSL find(String searchText) {
        return this;
    }

    public SOSL inAllFields() {
        return this;
    }

    public SOSL inNameFields() {
        return this;
    }

    public SOSL inEmailFields() {
        return this;
    }

    public SOSL inPhoneFields() {
        return this;
    }

    public SOSL inSidebarFields() {
        return this;
    }

    public SOSL returning(SObjectType returningObject) {
        return this;
    }

    public SOSL with(SObjectField field) {
        return this;
    }

    public SOSL with(SObjectField field1, SObjectField field2) {
        return this;
    }

    public SOSL with(SObjectField field1, SObjectField field2, SObjectField field3) {
        return this;
    }

    public SOSL with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4) {
        return this;
    }

    public SOSL with(SObjectField field1, SObjectField field2, SObjectField field3, SObjectField field4, SObjectField field5) {
        return this;
    }

    public SOSL with(List<SObjectField> fields) {
        return this;
    }

    public SOSL whereAre(FilterGroup filterGroup) {
        return this;
    }

    public SOSL whereAre(Filter filter) {
        return this;
    }

    public SOSL setLimit(Integer amount) {
        return this;
    }

    public SOSL globalLimit(Integer amount) {
        return this;
    }

    public SOSL offset(Integer startingRow) {
        return this;
    }

    public SOSL orderBy(SObjectField field) {
        return this;
    }

    public SOSL sortDesc() {
        return this;
    }

    public SOSL nullsLast() {
        return this;
    }

    public SOSL usingListView(String listView) {
        return this;
    }

    // public SOSL withDataCategory() Inner Class here

    public SOSL withDivision(String division) {
        // WITH DIVISION
        return this;
    }

    public SOSL withHighlight() {
        // WITH HIGHLIGHT
        return this;
    }

    public SOSL withMetadata(String metadata) {
        // WITH METADATA
        return this;
    }

    public SOSL withNetworkEqual() {
        // WITH NETWORK =
        return this;
    }

    public SOSL withNetworkIn() {
        // WITH NETWORK IN
        return this;
    }

    public SOSL withPriceBookId(Id priceBookId) {
        // WITH PricebookId =
        return this;
    }

    public SOSL withSnippet(String snippet) {
        // WITH SNIPPET
        return this;
    }

    public SOSL withoutSpellCorrection() {
        // WITH SPELL_CORRECTION = false
        return this;
    }

    public interface QueryClause {
        String toString();
    }

    private class QueryBuilder implements QueryClause {
        private List<QueryClause> clauses = new QueryClause[10];

        public QueryBuilder(String ofObject) {
            //
        }

        public QMainFilterGroup conditions {
            get {
                if (clauses[4] == null) {
                    clauses.set(4, new QMainFilterGroup());
                }
                return (QMainFilterGroup) clauses[4];
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
