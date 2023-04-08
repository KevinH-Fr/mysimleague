import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["newrecordContent", "openButton", "closeButton"]

  connect() {
    this.newrecordContentTarget.hidden = true
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
  //  this.element.remove()
    this.newrecordContentTarget.hidden = true  
    this.openButtonTarget.hidden = false
    this.closeButtonTarget.hidden = true
  }

  openDropdown() {
    this.newrecordContentTarget.hidden = false
    this.openButtonTarget.hidden = true
    this.closeButtonTarget.hidden = false
  }

  closeDropdown() {
    this.newrecordContentTarget.hidden = true
    this.openButtonTarget.hidden = false
    this.closeButtonTarget.hidden = true
  }

}
