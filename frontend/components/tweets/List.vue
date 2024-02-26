<template>
  <div v-for="(tweet, index) in props.tweets" :key="index">
      <div class="border-custom mb-2">
        <v-card class="px-5 py-5 rounded">
          <v-row>
            <v-col>
              <v-img :src="tweet.image_url" max-height="360px" class="mt-5"></v-img>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-card-title >{{ tweet.content }}</v-card-title>
              <v-card-subtitle >@{{ tweet.pseudo }}</v-card-subtitle>
            </v-col>
          </v-row>
          <v-row>
            <v-col
              cols="11"
              md="11"
            >
              <v-btn
                  prepend-icon="mdi-thumb-up"
                  :disabled="tweet.user_id === user.id"
                  class="mr-2"
              >
                <template v-slot:prepend>
                  <v-icon color="indigo-lighten-1"></v-icon>
                </template>

                +1
              </v-btn>
              <v-btn
                  prepend-icon="mdi-thumb-down-outline"
                  :disabled="tweet.user_id === user.id"
                  class="mr-2"
              >
                <template v-slot:prepend>
                  <v-icon color="red-lighten-1"></v-icon>
                </template>
                -1
              </v-btn>
              <v-btn
                  prepend-icon="mdi-pencil"
                  v-if="tweet.user_id === user.id"
                  @click="editTweet(tweet)"
                  class="mr-2"
              >
                <template v-slot:prepend>
                  <v-icon color="indigo-lighten-1"></v-icon>
                </template>
                Modifier
              </v-btn>
              <v-btn
                  prepend-icon="mdi-delete"
                  v-if="tweet.user_id === user.id"
                  @click="deleteTweet(tweet.id)"
              >
                <template v-slot:prepend>
                  <v-icon color="indigo-lighten-1"></v-icon>
                </template>
                Supprimer
              </v-btn>
            </v-col>
          </v-row>
        </v-card>
      </div>
    <v-dialog v-model="editModal">
      <EditTweet :tweet="selectedTweet" @closeModal="closeModal" />
    </v-dialog>
  </div>
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
const show = ref(false)
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
  selectedTweet.value = tweet;
  editModal.value = true;
};

const closeModal = () => {
  editModal.value = false;
  emit("index")
}

</script>
