<template>
  <div>
    <gov-heading size="l">Who is it for?</gov-heading>
    <gov-table>
      <template slot="body">
        <gov-table-row>
          <gov-table-header scope="row" top>Age of support listing user</gov-table-header>
          <gov-table-cell>
            <gov-list v-if="serviceCriteria.age_group.length" type="unordered" :bullet="true">
              <li v-for="(item, index) in serviceCriteria.age_group" :key="`service.criteria.age_group.${index}`">{{ item }}</li>
            </gov-list>
            <gov-hint v-else>No specific requirement</gov-hint>
          </gov-table-cell>
        </gov-table-row>
        <gov-table-row>
          <gov-table-header scope="row" top>Disability requirements</gov-table-header>
          <gov-table-cell>
            <gov-list v-if="serviceCriteria.disability.length" type="unordered" :bullet="true">
              <li v-for="(item, index) in serviceCriteria.disability" :key="`service.criteria.disability.${index}`">{{ item }}</li>
            </gov-list>
            <gov-hint v-else>No specific requirement</gov-hint>
          </gov-table-cell>
        </gov-table-row>
        <gov-table-row>
          <gov-table-header scope="row" top>Gender specific</gov-table-header>
          <gov-table-cell>
            <gov-list v-if="serviceCriteria.gender.length" type="unordered" :bullet="true">
              <li v-for="(item, index) in serviceCriteria.gender" :key="`service.criteria.gender.${index}`">{{ item }}</li>
            </gov-list>
            <gov-hint v-else>No specific requirement</gov-hint>
          </gov-table-cell>
        </gov-table-row>
        <gov-table-row>
          <gov-table-header scope="row" top>Benefits status</gov-table-header>
          <gov-table-cell>
            <gov-list v-if="serviceCriteria.benefits.length" type="unordered" :bullet="true">
              <li v-for="(item, index) in serviceCriteria.benefits" :key="`service.criteria.benefits.${index}`">{{ item }}</li>
            </gov-list>
            <gov-hint v-else>No specific requirement</gov-hint>
          </gov-table-cell>
        </gov-table-row>
        <gov-table-row>
          <gov-table-header scope="row" top>Employment status</gov-table-header>
          <gov-table-cell>
            <gov-list v-if="serviceCriteria.employment.length" type="unordered" :bullet="true">
              <li v-for="(item, index) in serviceCriteria.employment" :key="`service.criteria.employment.${index}`">{{ item }}</li>
            </gov-list>
            <gov-hint v-else>No specific requirement</gov-hint>
          </gov-table-cell>
        </gov-table-row>
      </template>
    </gov-table>
  </div>
</template>

<script>
export default {
  name: "WhoForTab",
  props: {
    service: {
      type: Object,
      required: true
    }
  },
  computed: {
    serviceCriteria() {
      return {
        age_group: this.service.criteria.age_group
          ? this.service.criteria.age_group.split(", ")
          : [],
        disability: this.service.criteria.disability
          ? this.service.criteria.disability.split(", ")
          : [],
        employment: this.service.criteria.employment
          ? this.service.criteria.employment.split(", ")
          : [],
        gender: this.service.criteria.gender
          ? this.service.criteria.gender.split(", ")
          : [],
        benefits: this.service.criteria.benefits
          ? this.service.criteria.benefits.split(", ")
          : []
      };
    }
  }
};
</script>
