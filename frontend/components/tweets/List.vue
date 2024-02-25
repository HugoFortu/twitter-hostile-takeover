<template>
  <v-row  v-for="(tweet, index) in props.tweets" :key="index">
    <v-col>
      <v-card class="mb-2 border px-5 py-5 rounded">
        <v-row>
          <v-col>
            <v-img :src="tweet.image_url" max-height="360px" class="mt-5"></v-img>
          </v-col>
        </v-row>
        <v-row>
          <v-col
            cols="10"
            md="10">
            <v-card-title >{{ tweet.content }}</v-card-title>
            <v-card-subtitle class="mb-5">@{{ tweet.pseudo }}</v-card-subtitle>
          </v-col>
          <v-col
            cols="2"
            md="2"
          >
            <v-btn
              density="compact"
              :disabled="tweet.user_id === user.id"
              icon="mdi-thumb-up"
            ></v-btn>
            <v-btn
              density="compact"
              :disabled="tweet.user_id === user.id"
              icon="mdi-thumb-down"
            ></v-btn>
            <v-btn
              density="compact"
              v-if="tweet.user_id === user.id"
              icon="mdi-pencil"
              @click="editTweet(tweet)"
            ></v-btn>
            <v-btn
              density="compact"
              v-if="tweet.user_id === user.id"
              icon="mdi-delete"
              @click="deleteTweet(tweet.id)"
            ></v-btn>
          </v-col>
        </v-row>
      </v-card>
    </v-col>
      <v-dialog v-model="editModal">
      <EditTweet :tweet="selectedTweet" @closeModal="closeModal" />
    </v-dialog>
  </v-row>
</template>
<script setup>
import { useAuthStore } from "~/store/auth";
import EditTweet from "~/components/tweets/Edit.vue";
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
const selectedTweet = ref({})
const editModal = ref(false)

const deleteTweet = (id) => {
  $fetch(`${config.public.baseApiUrl}/tweets/${id}`, {
    method: "DELETE",
    credentials: "include",
  }).then(() => {
    emit("index")
  }).catch((error) => {
    console.log(error);
  })
};

const editTweet = (tweet) => {
  console.log(tweet);
  selectedTweet.value = tweet;
  editModal.value = true;
};

const closeModal = () => {
  editModal.value = false;
  emit("index")
}

</script>
