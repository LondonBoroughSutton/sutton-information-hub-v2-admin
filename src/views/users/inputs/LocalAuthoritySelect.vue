<template>
  <div>
    <search-select
      id="local_authorities"
      label="Local Authorities"
      :options="localAuthorityOptions"
      :value="selectedOption"
      :error="null"
      @input="$emit(`update:local_authority_id`, $event.value)"
      @remove="$emit('update:local_authority_id', null)"
    />
    <gov-error-message
      v-if="errors.has('local_authority_id')"
      v-text="errors.get('local_authority_id')"
      for="local_authorities"
    />
  </div>
</template>

<script>
import http from "@/http";
import SearchSelect from "@/components/SearchSelect";

export default {
  components: {
    SearchSelect
  },
  props: {
    local_authority_id: {
      type: String,
      default: null
    },
    errors: {
      required: true,
      type: Object
    }
  },
  data() {
    return {
      localAuthorities: [],
      loading: false
    };
  },
  computed: {
    localAuthorityOptions() {
      return this.localAuthorities.map(this.normaliseOption);
    },
    selectedOption() {
      const selected = this.localAuthorities.find(la => {
        return la.id === this.local_authority_id;
      });
      return selected ? this.normaliseOption(selected) : null;
    }
  },
  methods: {
    async fetchLocalAuthorities() {
      this.loading = true;
      const {
        data: { data: localAuthorities }
      } = await http.get("/local-authorities");
      this.localAuthorities = localAuthorities;
      this.loading = false;
    },
    normaliseOption(localAuthority) {
      const label = [localAuthority.name];
      if (localAuthority.alt_name) {
        label.push(`(${localAuthority.alt_name})`);
      }
      return {
        text: label.join(" "),
        value: localAuthority.id
      };
    }
  },
  created() {
    this.fetchLocalAuthorities();
  }
};
</script>

<style lang="scss" scoped>
</style>
