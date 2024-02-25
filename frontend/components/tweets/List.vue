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
            <v-card-subtitle class="mb-5">Author</v-card-subtitle>
          </v-col>
          <v-col
            cols="1"
            md="1"
          >
            <v-btn
              :disabled="tweet.user_id === user.id "
              icon="mdi-thumb-up"
            ></v-btn>
          </v-col>
          <v-col
            cols="1"
            md="1"
          >
            <v-btn :disabled="tweet.user_id === user.id"
            icon="mdi-thumb-down"
            ></v-btn>
          </v-col>
        </v-row>
      </v-card>
    </v-col>
  </v-row>

</template>
<script setup>
import { useAuthStore } from "~/store/auth";
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const props = defineProps({
  tweets: {
    type: Array,
    required: true
  }
})

</script>
