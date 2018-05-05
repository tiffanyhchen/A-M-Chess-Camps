////////////////////////////////////////////////
//// Setting up a general ajax method to handle
//// transfer of data between client and server
////////////////////////////////////////////////
function run_ajax(method, data, link, callback=function(res){students.get_students()}){
  $.ajax({
    method: method,
    data: data,
    url: link,
    success: function(res) {
      students.errors = {};
      callback(res);
    },
    error: function(res) {
      console.log("error");
      students.errors = res.responseJSON;
    }
  })
}

///////////////////////////////////////////////////////
//// A component to create a camp instructor list item
///////////////////////////////////////////////////////
Vue.component('student-row', {

  template: `
    <li>
      <a v-on:click="remove_signup(student)" class="remove">x&nbsp;&nbsp;</a>
      {{ student.last_name }},&nbsp;{{ student.first_name }}
    </li>
  `,

  props: {
    student: Object
  },

  data: function () {
    return {
      camp_id: 0
    }
  },

  created() {
    this.camp_id = $('#camp_id').val();
  },

  methods: {
    remove_signup: function(student){
      run_ajax('DELETE', {student: student}, '/camps/'.concat(this.camp_id, '/students/',student['id'],'.json'));
    }
  }
});


/////////////////////////////////////////////
//// A component for adding a new instructor
/////////////////////////////////////////////
var new_form = Vue.component('new-student-form', {
  template: '#registration-form-template',

  mounted() {
    // need to reconnect the materialize select javascript 
    $('#registration_student_id').material_select()
  },

  data: function () {
    return {
        camp_id: 0,
        student_id: 0,
        errors: {}
    }
  },

  methods: {
    submitForm: function (x) {
      new_post = {
        camp_id: this.camp_id,
        student_id: this.student_id
      }
      run_ajax('POST', {student: new_post}, '/registrations.json')
      this.switch_modal()
    }
  },
})



//////////////////////////////////////////
////***  The Vue instance itself  ***////
/////////////////////////////////////////
var students = new Vue({

  el: '#signups',

  data: {
    camp_id: 0,
    students: [],
    modal_open: false,
    errors: {}
  },

  created() {
    this.camp_id = $('#camp_id').val();
    console.log(this.camp_id)
  },

  methods: {
    switch_modal: function(event){
      this.modal_open = !(this.modal_open);
    },

    get_students: function(){
      run_ajax('GET', {}, '/camps/'.concat(this.camp_id, '/students.json'), function(res){students.students = res});
    }
  },

  mounted: function(){
    this.get_students();
  }
});