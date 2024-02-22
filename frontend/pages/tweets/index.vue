<template>

</template>

<script setup>
const index = () => {
  $fetch.raw(`http://0.0.0.0:8080/users/sign_in`, {
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


      })
}
</script>