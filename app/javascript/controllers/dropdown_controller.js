import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdownContent", "openButton", "closeButton"]

  connect() {
    this.dropdownContentTarget.hidden = true
    this.closeButtonTarget.hidden = true
    console.log("stiumuls dropdown controller")
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
    }
  //  console.log(e.detail.success)
  }

  hideModal(){
    this.element.remove()
  }

  openDropdown() {

    this.dropdownContentTarget.hidden = false
    this.openButtonTarget.hidden = true
    this.closeButtonTarget.hidden = false

    this.getId()
  }

  closeDropdown() {
    this.dropdownContentTarget.hidden = true
    this.openButtonTarget.hidden = false
    this.closeButtonTarget.hidden = true
  }


  getId() {
   // event.preventDefault()
   let ligueId = this.data.get("ligueId")
    console.log("show id: " + ligueId)
    //this.visit(`/ligues/${id}?show_ligue=${id}`)
  }

}
