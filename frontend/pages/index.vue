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
import { ref, onMounted } from "vue";
import { storeToRefs } from "pinia";
import { useAuthStore } from "~/store/auth";
import NewTweet from "~/components/tweets/New.vue";
import tweetList from "~/components/tweets/List.vue";

const config = useRuntimeConfig();
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const tweets = ref([])
const page = ref(1)
const index = () => {
  $fetch(`${config.public.baseApiUrl}/tweets`, {
    credentials: "include",
    params: {
      page: page.value,
    }
  }).then((response) => {
    tweets.value = response
  })
}

onMounted(() => {
  index();
});
</script>
