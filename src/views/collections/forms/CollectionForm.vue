<template>
  <div>

    <ck-text-input
      :value="name"
      @input="onInput('name', $event)"
      id="name"
      label="Name"
      type="text"
      :error="errors.get('name')"
    />

    <ck-textarea-input
      v-if="subtitle"
      :value="subtitle"
      @input="$emit('update:subtitle', $event); $emit('clear', 'subtitle')"
      id="subtitle"
      label="Subtitle"
      :hint="`A one line summary of the ${type}.`"
      :maxlength="150"
      :error="errors.get('subtitle')"
    />

    <ck-textarea-input
      :value="intro"
      @input="$emit('update:intro', $event); $emit('clear', 'intro')"
      id="intro"
      :label="`Description of ${type}`"
      :hint="`A short summary detailing what type of services the ${type} contains.`"
      :maxlength="150"
      :error="errors.get('intro')"
    />

    <ck-image-input
      @input="onInput('image_file_id', $event.file_id)"
      id="image"
      :label="`${type} image`"
      accept="image/x-png"
      :existing-url="id ? apiUrl(`/collections/${lowerPluralType}/${id}/image.png?v=${now}`) : undefined"
    />

    <gov-heading size="m">Sideboxes</gov-heading>

    <gov-body>
      Create up to three sideboxes that will can be used to display information
      on the category results page.
    </gov-body>

    <ck-sideboxes-input
      :sideboxes="sideboxes"
      @input="onInput('sideboxes', $event)"
      :errors="errors"
    />

    <gov-label class="govuk-!-font-weight-bold">Taxonomies</gov-label>
    <category-taxonomy-input
      :invalid="errors.has('category_taxonomies')"
      :value="category_taxonomies"
      @input="$emit('update:category_taxonomies', $event)"
      :error="errors.get('category_taxonomies')"
      @clear="$emit('clear', 'category_taxonomies')"
      :hierarchy="false"
    />

  </div>
</template>

<script>
import CkImageInput from "@/components/Ck/CkImageInput";
import CategoryTaxonomyInput from "@/views/services/inputs/CategoryTaxonomyInput";
import CkSideboxesInput from "@/views/collections/inputs/SideboxesInput";

export default {
  name: "CollectionForm",
  components: {
    CkImageInput,
    CategoryTaxonomyInput,
    CkSideboxesInput
  },
  props: {
    errors: {
      required: true,
      type: Object
    },
    name: {
      required: true
    },
    intro: {
      required: true
    },
    subtitle: {
      required: false,
      default: null
    },
    order: {
      required: true
    },
    sideboxes: {
      required: true
    },
    category_taxonomies: {
      required: true
    },
    type: {
      type: String,
      validator: function(value) {
        return ["Persona", "Category"].indexOf(value) !== -1;
      }
    },
    id: {
      required: false,
      type: String
    }
  },
  computed: {
    lowerType() {
      return this.type.toLowerCase();
    },
    lowerPluralType() {
      switch (this.lowerType) {
        case "persona":
          return "personas";
        case "category":
          return "categories";
      }
    }
  },
  methods: {
    onInput(field, value) {
      this.$emit(`update:${field}`, value);
      this.$emit("clear", field);
    }
  }
};
</script>
