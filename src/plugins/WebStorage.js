/**
 * Vue Plugin to manage Auth sessionStorage
 * /plugins/WebStorage.js
 */
export default {
  install(Vue) {
    Vue.prototype.$webStorage = webStorage;
  },
};

/**
 * Storage Object.
 * Defaults to a fall back storage (Null Object Pattern) for use in the rare cases sessionStorage or localStorage is unavailable.
 * Expectation is it will be overwritten with a reference to either sessionStorage or localStorage.
 */
let storage = {
  items: {},
  setItem(key, item) {
    this.items[key] = item;
  },
  getItem(key) {
    return this.items.hasOwnProperty(key) ? this.items[key] : null;
  },
  removeItem(key) {
    if (this.items.hasOwnProperty(key)) {
      delete this.items[key];
    }
  },
};

/**
 * Export object
 * Interface to allow access to whichever storage type is used
 */
const webStorage = {
  setStorage: (storageType) => {
    if (storageAvailable(storageType)) {
      storage = window[storageType];
      return true;
    } else {
      return false;
    }
  },
  getStorage: () => {
    return storage;
  },
  set: (key, item) => {
    if (typeof item === 'object') {
      item = JSON.stringify(item);
    }
    storage.setItem(key, item);
  },
  get: (key) => {
    return JSON.parse(storage.getItem(key));
  },
  remove: (key) => {
    storage.removeItem(key);
  },
};

/**
 * Check the requested storage type is available
 * @param {String} type
 */
function storageAvailable(type) {
  let storage;
  try {
    storage = window[type];
    const x = '__storage_test__';
    storage.setItem(x, x);
    storage.removeItem(x);
    return true;
  } catch (e) {
    return (
      e instanceof DOMException &&
      // everything except Firefox
      (e.code === 22 ||
        // Firefox
        e.code === 1014 ||
        // test name field too, because code might not be present
        // everything except Firefox
        e.name === 'QuotaExceededError' ||
        // Firefox
        e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
      // acknowledge QuotaExceededError only if there's something already stored
      storage &&
      storage.length !== 0
    );
  }
}
