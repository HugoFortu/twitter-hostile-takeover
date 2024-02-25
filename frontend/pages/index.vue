<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
        md="12"
      >
      <NewTweet
      @refresh="index"
      />
      </v-col>
    </v-row>
    <v-row>
        <v-col
          cols="12"
          md="12"
        >
        <tweetList
          :tweets="tweets"
        />
        </v-col>
      </v-row>
  </v-container>



</template>

<script setup>
import { storeToRefs } from "pinia";
import { useAuthStore } from "~/store/auth";
import NewTweet from "~/components/tweets/New.vue";
import tweetList from "~/components/tweets/List.vue";

const config = useRuntimeConfig();
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const tweets = ref([])

const index = () => {
  $fetch(`${config.public.baseApiUrl}/tweets`, {
    credentials: "include",
  }).then((response) => {
    tweets.value = response
  })
}

onMounted(() => {
  index();
});
</script>
