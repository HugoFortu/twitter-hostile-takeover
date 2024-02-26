<template>
  <v-container>
    <v-row>
      <v-col>
        <NewTweet
            @refresh="index"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <tweetList
            :tweets="tweets"
            @index="index"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import tweetList from "~/components/tweets/List.vue";
import NewTweet from "~/components/tweets/New.vue";
import { storeToRefs } from "pinia";
import { useAuthStore } from "~/store/auth";
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const config = useRuntimeConfig();
const tweets = ref([])
const page = ref(1)
const index = () => {
  $fetch(`${config.public.baseApiUrl}/tweets/my_tweets`, {
    credentials: "include",
    params: {
      page: page.value,
      user_id: user.value.id
    }
  }).then((response) => {
    tweets.value = response
  })
}

onMounted(() => {
  index();
});
</script>