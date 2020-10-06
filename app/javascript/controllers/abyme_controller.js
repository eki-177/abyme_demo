import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['template', 'associations'];

  connect() {
    console.log('Abyme Connect');
  }

  get position() {
    return this.data.get('position') === 'before' ? 'beforeend' : 'afterbegin';
  }

  add_association(event) {
    event.preventDefault();

    const content = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime()
    );

    console.log(this.position);
    this.associationsTarget.insertAdjacentHTML(this.position, content);
  }

  remove_association(event) {
    event.preventDefault();

    let wrapper = event.target.closest('.abyme--fields');
    wrapper.querySelector("input[name*='_destroy']").value = 1;
    wrapper.style.display = 'none';
  }
}
