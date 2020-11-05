<template>
  <div>
    <ck-text-input
      :value="address.address_line_1"
      @input="onInput('address_line_1', $event)"
      id="address_line_1"
      label="Address Line 1"
      type="text"
      :error="getError('address_line_1')"
    />

    <ck-text-input
      :value="address.address_line_2"
      @input="onInput('address_line_2', $event)"
      id="address_line_2"
      label="Address Line 2"
      type="text"
      :error="getError('address_line_2')"
    />

    <ck-text-input
      :value="address.address_line_3"
      @input="onInput('address_line_3', $event)"
      id="address_line_3"
      label="Address Line 3"
      type="text"
      :error="getError('address_line_3')"
    />

    <ck-text-input
      :value="address.city"
      @input="onInput('city', $event)"
      id="city"
      label="City"
      type="text"
      :error="getError('city')"
    />

    <ck-text-input
      :value="address.county"
      @input="onInput('county', $event)"
      id="county"
      label="County"
      type="text"
      :error="getError('county')"
    />

    <ck-text-input
      :value="address.postcode"
      @input="onInput('postcode', $event)"
      id="postcode"
      label="Postcode"
      type="text"
      :error="getError('postcode')"
    />

    <ck-select-input
      :value="address.country"
      @input="onInput('country', $event)"
      id="country"
      label="Country"
      :options="countries"
      :error="getError('country')"
    />
      <gov-button v-if="submitting" disabled type="submit">{{ location_id? 'Updating' : 'Adding' }}...</gov-button>
      <gov-button v-else @click="onSubmit" type="submit">{{ location_id? 'Update' : 'Add' }} Address</gov-button>&nbsp;
      <gov-button v-if="location_id" @click="onRemoveAddress()" error>Remove Address</gov-button>
      <ck-submit-error v-if="hasError()" />
      <gov-hint v-if="submitted">{{ submitted }}</gov-hint>
  </div>
</template>

<script>
import Form from "@/classes/Form";
import http from "@/http";
import countries from "@/storage/countries";

export default {
  props: {
    location_id: {
      required: false,
      default: null
    }
  },
  data() {
    return {
      countries,
      address: {
        address_line_1: "",
        address_line_2: "",
        address_line_3: "",
        city: "",
        county: "",
        postcode: "",
        country: "United Kingdom"
      },
      form: null,
      loading: false,
      submitting: false,
      submitted: null
    };
  },
  methods: {
    onInput(field, value) {
      this.address[field] = value;
    },

    getError(field) {
      return this.form ? this.form.$errors.get(field) : null;
    },

    hasError() {
      return this.form ? this.form.$errors.any() : false;
    },

    async onSubmit() {
      try {
        this.submitting = true;

        this.form = new Form(
          Object.assign(
            {
              accessibility_info: "",
              has_wheelchair_access: false,
              has_induction_loop: false
            },
            this.address
          )
        );

        let response;
        if (this.location_id) {
          // Post the location if new.
          response = await this.form.put(`/locations/${this.location_id}`);
        } else {
          // Put the location if exisiting
          response = await this.form.post("/locations");
        }
        // Feedback success
        this.showSuccess();

        // Update the Address
        this.updateAddress(response.data);

        this.$emit(`update:location_id`, response.data.id);
        this.$emit("clear-location", response.data.id);
      } catch (error) {
        this.submitting = false;
      }
    },

    onRemoveAddress() {
      this.updateAddress({
        address_line_1: "",
        city: "",
        county: "",
        postcode: "",
        country: "United Kingdom"
      });
      this.$emit(`update:location_id`, null);
      this.$emit("clear-location", null);
    },

    async fetchLocation() {
      this.loading = true;
      const {
        data: { data: location }
      } = await http.get(`/locations/${this.location_id}`);

      // Update the Address
      this.updateAddress(location);
      this.loading = false;
    },

    updateAddress(location) {
      this.address.address_line_1 = location.address_line_1;
      this.address.address_line_2 = location.address_line_2 || "";
      this.address.address_line_3 = location.address_line_3 || "";
      this.address.city = location.city;
      this.address.county = location.county;
      this.address.postcode = location.postcode;
      this.address.country = location.country;
    },
    showSuccess() {
      this.submitting = false;
      this.submitted = this.location_id ? "Address updated" : "Address added";
      window.setTimeout(() => {
        this.submitted = null;
      }, 3.0 * 1000);
    }
  },
  created() {
    if (this.location_id) {
      this.fetchLocation();
    }
  }
};
</script>

<style lang="scss" scoped>
</style>
