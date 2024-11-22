import boto3

ssm = boto3.client('ssm')


class ParameterStoreHelper:
    @staticmethod
    def get_value_from_ssm_parameter_store(name: str, with_decryption: bool = False) -> str:
        param_obj = ssm.get_parameter(Name=name, WithDecryption=with_decryption)
        value = param_obj['Parameter']['Value']
        return value

    @staticmethod
    def get_list_from_ssm_parameters_store(name: list, with_decryption: bool = False) -> dict:
        result = {}
        param_list = ssm.get_parameters(Names=name, WithDecryption=with_decryption)
        for param in param_list['Parameters']:
            result[param['Name']] = param['Value']
        return result
