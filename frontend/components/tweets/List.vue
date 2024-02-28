<template>
  <div v-for="(tweet, index) in props.tweets" :key="index">
      <div class="border-custom mb-8">
        <CardTweet :key="tweet" :tweet="tweet" @openEditModal(tweet)="editModal = true" />
      </div>
    <v-dialog v-model="editModal">
      <EditTweet :tweet="selectedTweet" @closeModal="closeModal" />
    </v-dialog>
  </div>

</template>
<script setup>
import { ref } from "vue";
import { useAuthStore } from "~/store/auth";
import EditTweet from "~/components/tweets/Edit.vue";
import CardTweet from "~/components/tweets/Card.vue";
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const config = useRuntimeConfig();
const emit = defineEmits();
const props = defineProps({
  tweets: {
    type: Array,
    required: true
  }
})
const tweets = ref([])
const selectedTweet = ref({})
const editModal = ref(false)
const show = ref(false)
const page = ref(1)




const closeModal = () => {
  editModal.value = false;
  key.value++
}

</script>
