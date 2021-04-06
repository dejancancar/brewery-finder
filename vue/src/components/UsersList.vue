<template>
  <table>
      <thead>
          <tr>
              <td>User Id</td>
              <td>Username</td>
          </tr>
      </thead>
      <tbody v-for="user in UsersArray" :key="user.userId">
          <tr>
              <!-- Loop to add all users per row -->
              <td>{{user.userId}}</td>
              <td><router-link :to="{name: 'userToBrewer', params: {userId: user.userId}}">{{user.username}}</router-link></td>
          </tr>
      </tbody>
  </table>
</template>

<script>
export default {
    name: "users-list",
    props: {
        users: Array
    },
    data(){
        return{

        }
    },
    methods:{

    },
    computed:{

    }
};
</script>

<style>

</style>