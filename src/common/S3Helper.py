import boto3
from botocore.config import Config
from common.Constants import MAX_ALLOWED_DOCUMENT_SIZE_IN_BYTES  # pylint: disable= E0611
from common.Constants import PRESIGNED_URL_EXPIRY_SECONDS  # pylint: disable= E0611

s3_client = boto3.client('s3', config=Config(signature_version='s3v4'))


class S3Helper:
    @staticmethod
    def generate_presigned_url_post(method_parameters, metadata_dict):
        """
        Generate a presigned Amazon S3 URL that can be used to perform an action.

        Parameters
        ----------

        method_parameters: dict
            contains Bucket name and Key values
        metadata_dict: dict
            Dictionary of valid object metadata.

        Return
        -------
        url: dict
            The presigned URL dict containing the url, fields of metadata and the signature
        """

        # meta-data to be attached along with document object in the s3 bucket
        fields = {

            "Content-Type": "application/csv",  # TODO - this must be dynamic in future
            "Cache-Control": "nocache",
            "acl": "private"
        }
        fields.update(metadata_dict)

        # Conditions to limit the capabilities of the presigned URL to required values
        conditions = [
            {"Content-Type": "application/csv"},
            {"Cache-Control": "nocache"},
            ["content-length-range", 1, MAX_ALLOWED_DOCUMENT_SIZE_IN_BYTES],
            {"acl": "private"}
        ]

        # adding all the meta-data as conditions
        conditions += [{key: val} for key, val in metadata_dict.items()]

        url = s3_client.generate_presigned_post(Bucket=method_parameters["Bucket"],
                                                Key=method_parameters["Key"],
                                                Fields=fields,
                                                Conditions=conditions,
                                                ExpiresIn=PRESIGNED_URL_EXPIRY_SECONDS
                                                )

        return url

    @staticmethod
    def generate_presigned_url(client_method, method_parameters):
        """
        Generate a presigned Amazon S3 URL that can be used to perform either get or put object.

        Parameters
        ----------
        client_method: str
            it can be either get_object or put_object based on the operation required
        method_parameters: dict
            contains Bucket name and Key values

        Return
        -------
        url: str
            The presigned URL dict containing the url with the signature
        """
        url = s3_client.generate_presigned_url(
            ClientMethod=client_method,
            Params=method_parameters,
            ExpiresIn=PRESIGNED_URL_EXPIRY_SECONDS
        )

        return url
