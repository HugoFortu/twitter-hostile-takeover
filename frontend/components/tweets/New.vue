<template>
  <div class="border-custom mt-5">
    <v-card class="px-5 py-5 rounded">
      <v-card-title class="mb-2">
        Créer un tweet
      </v-card-title>
      <v-row>
        <v-col
            cols="11"
            md="11"
        >
          <v-text-field
            class="pl-5 field-disabled"
            clearable
            clear-icon="mdi-close-circle"
            label="Emojis"
            v-model="emojisText"
            disabled
          ></v-text-field>
        </v-col>
        <v-col
            cols="1"
            md="1">
          <v-btn
              icon="mdi-close"
              density="compact"
              @click="clearEmojis"
              v-if="emojisText !== ''"
          ></v-btn>
        </v-col>

      </v-row>
      <v-row>
        <v-col
          cols="10"
          md="10"
        >
          <v-file-input
            clearable
            density="compact"
            v-model="image"
            label="Ajouter une image"
          ></v-file-input>
        </v-col>
          <v-col
            cols="2"
            md="2"
            class="text-right"
          >
          <v-btn
            @click="displayEmojis"
            density="compact"
          >
          😆
          </v-btn>
          <v-dialog v-model="selectEmoji">
            <EmojiPicker :native="true" @select="onSelectEmoji" />
          </v-dialog>
        </v-col>
      </v-row>
      <v-row>
        <v-col
            cols="12"
            md="12"
            class="text-right"
          >
          <v-btn
            @click="sendTweet"
            :disabled="image === null && emojisText === ''"
          >
            Poster
          </v-btn>
        </v-col>
      </v-row>
    </v-card>
  </div>
</template>

<script setup>
import EmojiPicker from 'vue3-emoji-picker'
import { storeToRefs } from "pinia";
import { useAuthStore } from "~/store/auth";
import 'vue3-emoji-picker/css'

const emit = defineEmits();
const config = useRuntimeConfig();
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const image = ref(null)
const selectEmoji = ref(false)
const emojisText = ref("")

const onSelectEmoji = (emoji) => {
  emojisText.value = emojisText.value + emoji.i;
  selectEmoji.value = false;
}

const clearEmojis = () => {
  emojisText.value = "";
}


const sendTweet = () => {
  const formData = new FormData();
  formData.append('tweet[image]', image.value[0]);
  formData.append('tweet[user_id]', user.value.id);
  formData.append('tweet[content]', emojisText.value);
  $fetch(`${config.public.baseApiUrl}/tweets`, {
    method: "POST",
    credentials: "include",
    body: formData
  }).then((response) => {
    emojisText.value = "";
    image.value = null;
    emit("refresh")
  })
};

const displayEmojis = () => {
  selectEmoji.value = !selectEmoji.value;
};
</script>
