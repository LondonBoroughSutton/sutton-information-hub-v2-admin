<template>
  <div>
    <gov-heading size="l">Step 3: add a Support listing</gov-heading>
    <gov-grid-row>
      <gov-grid-column width="one-half">

        <gov-body>
          You can create a listing for different types of support including: apps / digital, services, information (e.g. videos), groups, clubs, activities, help lines and advice
        </gov-body>
        <gov-body>You can then select a more specific description of your support offer.</gov-body>

        <gov-section-break size="l" />

        <ck-select-input
          :value="service.type"
          @input="$emit('input', { field: 'type', value: $event })"
          id="type"
          label="Type of support"
          hint="Choose one type of support"
          :options="typeOptions"
          :error="errors.get('service.type')"
        />

        <ck-text-input
          :value="service.name"
          @input="$emit('input', { field: 'name', value: $event })"
          id="name"
          :label="`What is the name of your ${service.type}? (required)`"
          type="text"
          :error="errors.get(['service.name', 'service.slug'])"
          placeholder="Dare2Care"
        />

        <ck-text-input
          :value="service.url"
          @input="$emit('input', { field: 'url', value: $event })"
          id="url"
          :label="`What is the web address of your ${service.type}? (optional)`"
          :hint="`This must start with ‘http://’ or ‘https://’. You can use your organisation’s website address if the ${service.type} doesn’t have its own.`"
          type="url"
          :error="errors.get('service.url')"
        />

        <slot />
      </gov-grid-column>
    </gov-grid-row>
  </div>
</template>

<script>
export default {
  props: {
    service: {
      type: Object,
      required: true
    },

    errors: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      typeOptions: [
        { text: "It is a Service", value: "service" },
        { text: "It is an Activity", value: "activity" },
        { text: "It is a Club", value: "club" },
        { text: "It is a Group", value: "group" },
        { text: "It is a Helpline", value: "helpline" },
        { text: "It is an Information", value: "information" },
        { text: "It is an App", value: "app" },
        { text: "It is an Advice", value: "advice" }
      ]
    };
  }
};
</script>
