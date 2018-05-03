$(document).on('ready', function() {


////////////////////////////////////////////////
//// Setting up a general ajax method to handle
//// transfer of data between client and server
////////////////////////////////////////////////
function run_ajax(method, data, link, callback=function(res){camp_instructors.get_camp_instructors()}){
  $.ajax({
    method: method,
    data: data,
    url: link,
    success: function(res) {
      camp_instructors.errors = {};
      callback(res);
    },
    error: function(res) {
      console.log("error");
      camp_instructors.errors = res.responseJSON;
    }
  })
}

//////////////////////////////////////////////
//// A component to create a dosage list item
//////////////////////////////////////////////
Vue.component('camp-instructor-row', {
  // Start with the template: two methods to consider...
  // (1) defining where to look for the HTML template in the index view
  // template: '#dosage-row',
  // _or_ (2) define it directly in the js file as such:
  template: `
    <li>
      <a v-on:click="remove_record(camp_instructor)" class="remove">x&nbsp;&nbsp;</a>
      {{ camp_instructor.instructor.name }}:&nbsp;&nbsp;
    </li>
  `,

  // Passed elements to the component from the Vue instance
  props: {
    camp_instructor: Object
  },

  // Behaviors associated with this component
  methods: {
    remove_record: function(camp_instructor){
      run_ajax('DELETE', {camp_instructor: camp_instructor}, '/camp_instructors/'.concat(camp_instructor['id'], '.json'));       
    }
  }
});

/////////////////////////////////////////
//// A component for adding a new dosage
/////////////////////////////////////////
var new_form = Vue.component('new-camp-instructor-form', {
  template: '#camp-instructor-form-template',

  mounted() {
    // need to reconnect the materialize select javascript 
    $('#camp_instructors_camp_id').material_select()
  },

  data: function () {
    return {
        camp_id: 0,
        instructor_id: 0,
        errors: {}
    }
  },

  methods: {
    submitForm: function (x) {
      new_post = {
        camp_id: this.camp_id,
        instructor_id: this.instructor_id,
      }
      run_ajax('POST', {camp_instructor: new_post}, '/camp_instructors.json')
      this.switch_modal()
    }
  },
})


//////////////////////////////////////////
////***  The Vue instance itself  ***////
/////////////////////////////////////////
var camp_instructors = new Vue({

  el: '#camp_instructor_handling',

  data: {
    visit_id: 0,
    camp_instructors: [],
    modal_open: false,
    errors: {}
  },

  created() {
    // read the visit_id from the page when instance created
    this.camp_id = $('#camp_id').val();
  },

  methods: {
    switch_modal: function(event){
      this.modal_open = !(this.modal_open);
    },

    get_camp_instructors: function(){
      run_ajax('GET', {}, '/camps/'.concat(this.camp_id, '/camp_instructors.json'), function(res){camp_instructors.camp_instructors = res});
    }
  },

  mounted: function(){
    this.get_camp_instructors();
  }
});


});
