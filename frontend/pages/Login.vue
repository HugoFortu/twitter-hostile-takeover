<template>
  <div>
    <v-form>
      <v-container class="toto">
        <v-card>
          <v-card-title>
            Inscription
          </v-card-title>
          <v-col
            cols="12"
            md="12"
          >
            <v-text-field
              v-model="email"
              label="Email"
              hide-details
              required
            ></v-text-field>
          </v-col>

          <v-col
            cols="12"
            md="12"
          >
            <v-text-field
              v-model="password"
              :counter="10"
              label="Mot de passe"
              hide-details
              required
            ></v-text-field>
          </v-col>
          <v-col
              cols="12"
              md="12"
          >
            <v-text-field
                v-model="passwordConfirmation"
                :counter="10"
                label="Confirmer le mot de passe."
                hide-details
                required
            ></v-text-field>
          </v-col>
          <v-btn
          @click="registration">
            Valider
          </v-btn>
        </v-card>
      </v-container>
    </v-form>
    <v-form >
      <v-container class="login">
        <v-card>
          <v-card-title>
            Connexion
          </v-card-title>
          <v-col
              cols="12"
              md="12"
          >
            <v-text-field
                v-model="email"
                label="Email"
                hide-details
                required
            ></v-text-field>
          </v-col>

          <v-col
              cols="12"
              md="12"
          >
            <v-text-field
                v-model="password"
                :counter="10"
                label="Mot de passe"
                hide-details
                required
            ></v-text-field>
          </v-col>
          <v-btn
              @click="login">
            Valider
          </v-btn>
        </v-card>
      </v-container>
    </v-form>
  </div>
</template>


<script setup>
import { ref } from "vue";

const config = useRuntimeConfig();
const valid = ref(null);
const email = ref("");
const password = ref("");
const passwordConfirmation = ref("");
const registration = () => {
  $fetch.raw(`${config.public.baseApiUrl}/users`, {
    method: "POST",
    credentials: "include",
    body: {
      user: {
        email: email.value,
        password: password.value,
        password_confirmation: passwordConfirmation.value
      }
    },
  }).then((response) => {
    if (response.ok) {
      sessionStorage.setItem("isLogged", response.ok);
      sessionStorage.setItem("token", response.headers.get("authorization").split(' ')[1]);
    }
  })
}

const login = () => {
  $fetch.raw(`${config.public.baseApiUrl}/users/sign_in`, {
    method: "POST",
    credentials: "include",
    body: {
      user: {
        email: email.value,
        password: password.value
      }
    },
  })
      .then((response) => {
        sessionStorage.setItem("isLogged", response.ok);
        if (response.ok) {
          sessionStorage.setItem("token", response.headers.get("authorization").split(' ')[1]);
          return navigateTo('/');
        }
      })
}


</script>
