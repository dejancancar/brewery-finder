<template>
  <table>
    <thead>
      <tr class="headers">
        <td >User Id</td>
        <td id="left-pad">Username</td>
      </tr>
    </thead>
    <tbody v-for="user in users" :key="user.userId">
      <tr class="evens">
        <!-- Loop to add all users per row -->
        <td class="center" id="margin-right"> {{ user.userId }}</td>
        <td id="row-two" >
          <router-link class="link"
            :to="{ name: 'create-brewery', params: { username: user.username } }"
            >{{ user.username }}</router-link
          >
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
export default {
  name: "users-list",
  props: {
    users: Array,
  },
  data() {
    return {};
  },
  methods: {},
  computed: {},

};
</script>

<style scoped>
td{
  font-weight: bold;
  font-size: 17px;
  margin-right: 3px;
}
#row-two, #left-pad{
  padding-left: 30px ;
}
#margin-right{
  padding-right: 10px;
}
.link {
  color: black;
  text-decoration: none;
}
table{
  border-collapse: collapse;
  width: 25%;
}
tbody:nth-child(even){
background-color: #e0af1f;

}
tbody:hover{
  opacity: 50%;
}
.headers > td{
  font-size: 30px;
}
.center{
  text-align: center;
}
</style>