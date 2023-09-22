import { ValidationAcceptor, ValidationChecks } from 'langium';
import { PhysArchAstType, Person } from './generated/ast';
import type { PhysArchServices } from './phys-arch-module';

/**
 * Register custom validation checks.
 */
export function registerValidationChecks(services: PhysArchServices) {
    const registry = services.validation.ValidationRegistry;
    const validator = services.validation.PhysArchValidator;
    const checks: ValidationChecks<PhysArchAstType> = {
        Person: validator.checkPersonStartsWithCapital
    };
    registry.register(checks, validator);
}

/**
 * Implementation of custom validations.
 */
export class PhysArchValidator {

    checkPersonStartsWithCapital(person: Person, accept: ValidationAcceptor): void {
        if (person.name) {
            const firstChar = person.name.substring(0, 1);
            if (firstChar.toUpperCase() !== firstChar) {
                accept('warning', 'Person name should start with a capital.', { node: person, property: 'name' });
            }
        }
    }

}
